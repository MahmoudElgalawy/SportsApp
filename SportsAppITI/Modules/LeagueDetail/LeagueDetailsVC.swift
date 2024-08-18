//
//  LeagueDetailsVC.swift
//  SportsAppITI
//
//  Created by Mahmoud on 8/12/24.
//

import UIKit

class LeagueDetailsVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var imgNoData: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var collectionLeagueDet: UICollectionView!
    @IBOutlet var btnAddToFav: UIBarButtonItem!

    // MARK: - Properties
    var leagueID: Int!
    var leagueTitle: String = " "
    var league: LeagueModel!
    var isFavorite = true
    private var errorCount = 0
    private var networkManager = NetworkService.shared
    private var coreDataManager = CoreDataManager.shared
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    private var upcomingEvents = [EventModel]()
    private var teams = [TeamModel]()

    private var latestEvents = [EventModel]() {
        didSet { updateTeams() }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadLatestEvents()
        loadUpcomingEvents()
        checkIfFavorite()
        updateFavoriteButton()
    }

    // MARK: - Setup Methods
    private func setupUI() {
        titleLbl.text = leagueTitle.capitalized
        configureCollectionView()
        setupActivityIndicator()
    }
    private func setupActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }

    // MARK: - UI Update Methods
    private func updateTeams() {
        teams = latestEvents.map { event in
            TeamModel(teamKey: event.homeTeamKey,
                      teamName: event.eventHomeTeam,
                      teamLogo: event.homeTeamLogo,
                      players: []
                     )
        }
        collectionLeagueDet.reloadData()
    }

    private func handleErrors() {
        errorCount += 1
        if errorCount == 2 {
            let hasErrors = upcomingEvents.isEmpty && latestEvents.isEmpty
            imgNoData.isHidden = !hasErrors
            collectionLeagueDet.isHidden = hasErrors
            if hasErrors {
                imgNoData.image = UIImage(named: "bak")
                collectionLeagueDet.isHidden = true
            }
        }
    }

    private func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            switch sectionIndex {
            case 0:
                return self.createUpcomingSection()
            case 1:
                return self.createLatestSection()
            default:
                return self.createTeamsSection()
            }
        }
        collectionLeagueDet.setCollectionViewLayout(layout, animated: true)
    }

    // MARK: - Data Loading Methods
    private func loadEvents(endpoint: SportsAPI, completion: @escaping ([EventModel]?, Error?) -> Void) {
        networkManager.fetchData(from: endpoint, model: EventModelAPIResponse.self) { [weak self] results, error in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            if let error = error {
                print("Error fetching events: \(error)")
                completion(nil, error)
                return
            }
            guard let results = results else {
                print("No data received")
                completion(nil, error)
                return
            }
            DispatchQueue.main.async {
                let events = results.result
                if !events.isEmpty {
                    completion(events, nil)
                } else {
                    completion(nil, error)
                    print("No events found.")
                }
                self.collectionLeagueDet.reloadData()
            }
        }
    }

    private func loadUpcomingEvents() {
        loadEvents(endpoint: .getUpcomingEvents(leagueId: leagueID, fromDate: .now, toDate: .upcoming)) { events, error in
            if error != nil {
                self.handleErrors()
                return
            }
            self.upcomingEvents = events!
        }
    }

    private func loadLatestEvents() {
        loadEvents(endpoint: .getLatestResults(leagueId: leagueID, fromDate: .passed, toDate: .now)) { events, error in
            if error != nil {
                self.handleErrors()
                return
            }
            self.latestEvents = events!
        }
    }

    // MARK: - Actions
    @IBAction func addToFav(_ sender: Any) {
        isFavorite.toggle()
        updateFavoriteButton()
        if isFavorite {
            saveMovie()
        } else {
            let alert = UIAlertController(title: "Delete", message: "This league will be removed from favorites.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                self.isFavorite.toggle()
            }))
            alert.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { _ in
                self.deleteMovie()
            }))
            self.present(alert, animated: true)
        }
    }

    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true)
    }

    func saveMovie() {
        print("Saving league...")
        coreDataManager.storeLeague(league)
        print("League saved successfully.")
    }

    func deleteMovie() {
        print("Deleting league...")
        coreDataManager.deleteLeague(league)
        print("League deleted successfully.")
    }

    func checkIfFavorite() {
        guard let league = league else { return }
        let fetchedLeague = coreDataManager.fetchLeague(byKey: league.leagueKey)
        isFavorite = fetchedLeague != nil
        updateFavoriteButton()
    }

    func updateFavoriteButton() {
        btnAddToFav.image = UIImage(systemName: isFavorite ? "heart.fill" : "heart")
    }
}

// MARK: - UICollectionView Delegate
extension LeagueDetailsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath)?.reuseIdentifier == "TeamsCVC" {
            performSegue(withIdentifier: "goToTeamVC", sender: indexPath.row)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTeamVC",
           let teamsDetailsVC = segue.destination as? TeamsDetailsVC,
           let row = sender as? Int {
            teamsDetailsVC.viewModel.teamKey = teams[row].teamKey
        }
    }
}

// MARK: - UICollectionView DataSource
extension LeagueDetailsVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func createUpcomingSection() -> NSCollectionLayoutSection {
        return createSectionLayout(groupHeight: .absolute(UIScreen.main.bounds.height / 5), groupWidth: .fractionalWidth(0.85), orthogonalScrollingBehavior: .groupPagingCentered, headerEnabled: !upcomingEvents.isEmpty)
    }

    private func createLatestSection() -> NSCollectionLayoutSection {
        return createSectionLayout(groupHeight: .absolute(UIScreen.main.bounds.height / 5), orthogonalScrollingBehavior: .none, headerEnabled: !latestEvents.isEmpty)
    }

    private func createTeamsSection() -> NSCollectionLayoutSection {
        return createSectionLayout(groupHeight: .absolute(200), groupWidth: .absolute(150), orthogonalScrollingBehavior: .continuous, headerEnabled: !teams.isEmpty)
    }

    private func createSectionLayout(groupHeight: NSCollectionLayoutDimension, groupWidth: NSCollectionLayoutDimension = .fractionalWidth(1), orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior, headerEnabled: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: groupHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 12, trailing: 5)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = orthogonalScrollingBehavior
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 16, trailing: 5)

        section.visibleItemsInvalidationHandler = { items, offset, environment in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let scale = max(1.0 - (distanceFromCenter / environment.container.contentSize.width), 0.8)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }

        if headerEnabled {
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
            let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [headerSupplementary]
        }
        return section
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return upcomingEvents.count
        case 1:
            return latestEvents.count
        default:
            return teams.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        switch indexPath.section {
        case 0:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeaguesDetailsCVC", for: indexPath) as! LeaguesDetailsCVC
            (cell as! LeaguesDetailsCVC).configure(with: upcomingEvents[indexPath.row])
        case 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeaguesDetailsCVC", for: indexPath) as! LeaguesDetailsCVC
            (cell as! LeaguesDetailsCVC).configure(with: latestEvents[indexPath.row])
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamsCVC", for: indexPath) as! TeamsCVC
            (cell as! TeamsCVC).configure(with: teams[indexPath.row])
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LeagueDSecHed", for: indexPath) as! LeagueDSecHed
        header.lblSectionHeader.text = ["Upcoming Events", "Latest Results", "Teams"][indexPath.section]
        return header
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.animateCellAppearance()
    }
    
}
