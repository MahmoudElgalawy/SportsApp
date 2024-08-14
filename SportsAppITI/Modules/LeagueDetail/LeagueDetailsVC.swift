//
//  LeagueDetailsVC.swift
//  SportsAppITI
//
//  Created by Engy on 8/12/24.
//


import UIKit

class LeagueDetailsVC: UIViewController {
    @IBOutlet var imgNoData: UIImageView!
    @IBOutlet var collectionLeagueDet: UICollectionView!
    @IBOutlet var btnAddToFav: UIBarButtonItem!

    let inrenetIndicator = UIActivityIndicatorView(style: .large)
    var upComing = [EventModel]()
    var latest = [EventModel]() {
        didSet {
            updateTeams()
        }
    }
    var teams: [TeamModel] = []
    var leagueID: Int!

    var networkManger =  NWService.shared
    var leagueTitle: String = " "

    override func viewDidLoad() {
        super.viewDidLoad()
        title = leagueTitle.first!.uppercased() + leagueTitle.dropFirst().lowercased()
        configureCollectionView()
        setUpIndicator()
        LoadUpcomingEvents()
        LoadLatestEvents()
    }
    private func setUpIndicator (){
        inrenetIndicator.center = view.center
        inrenetIndicator.startAnimating()
        view.addSubview(inrenetIndicator)
    }

    func updateTeams() {
        for event in latest {
            let team = TeamModel(homeTeamKey: event.homeTeamKey, eventHomeTeam: event.eventHomeTeam, homeTeamLogo: event.homeTeamLogo)
            teams.append(team)
        }
        collectionLeagueDet.reloadData()
    }

    var errorCount = 0 {
        didSet {
            if errorCount == 2 {
                imgNoData.image = UIImage(named: "404")
            }
        }
    }
    var isFav = false {
        didSet {
            if isFav {
                imgVa = "heart.fill"
            } else {
                imgVa = "heart"
            }
            setupBarButton()
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

    private func LoadUpcomingEvents() {
        networkManger.getAllData(sportName: .getLatestResults(leagueId: leagueID,fromDate:.now, toDate:.upcoming), model: EventModelAPIResponse.self) { [self] results, error in
            inrenetIndicator.stopAnimating()
            if let error = error {
                print("Error fetching leagues: \(error)")
                self.errorCount += 1
                return
            }
            guard let results = results else {
                print("No data received")
                self.errorCount += 1
                return
            }
            DispatchQueue.main.async {
                let upcomingEvents = results.result
                if !upcomingEvents.isEmpty {
                    self.upComing = upcomingEvents
                } else {
                    self.errorCount += 1
                    print("No upcoming events found.")
                }
                self.collectionLeagueDet.reloadData()
            }
        }
    }

    private func LoadLatestEvents() {
        networkManger.getAllData(sportName: .getUpcomingEvents(leagueId: leagueID,fromDate:.passed,toDate:.now), model: EventModelAPIResponse.self) { [self] results, error in
            inrenetIndicator.stopAnimating()
            if let error = error {
                self.errorCount += 1
                print("Error fetching leagues: \(error)")
                return
            }
            guard let results = results else {
                self.errorCount += 1
                print("No data received")
                return
            }
            DispatchQueue.main.async {
                let upcomingEvents = results.result
                if !upcomingEvents.isEmpty {

                    self.latest = upcomingEvents
                } else {
                    self.errorCount += 1
                    print("No upcoming events found.")
                }
                self.collectionLeagueDet.reloadData()
            }
        }
    }
    func setupBarButton() {
        let button1 = UIBarButtonItem(image: UIImage(systemName: imgVa), style: .plain, target: self, action: #selector(action))
        self.navigationItem.rightBarButtonItem = button1
    }

    @objc func action() {
        isFav.toggle()
        if isFav {
            saveMovie()
        }  else {
            let alert = UIAlertController(title: "Delete", message: "New will be removed", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { UIAlertAction in
                self.isFav.toggle()
            }))
            alert.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { UIAlertAction in
                self.deleteMovie()
            }))
            self.present(alert, animated: true)
        }
        setupBarButton()
    }

    @IBAction func addToFav(_ sender: Any) {
        // Add to favorites functionality
    }

    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension LeagueDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func createUpcomingSection() -> NSCollectionLayoutSection {
        return createSectionLayout(groupHeight: .absolute(UIScreen.main.bounds.height / 5), orthogonalScrollingBehavior: .continuous)
    }

    private func createLatestSection() -> NSCollectionLayoutSection {
        return createSectionLayout(groupHeight: .absolute(UIScreen.main.bounds.height / 5), orthogonalScrollingBehavior: .none)
    }

    private func createTeamsSection() -> NSCollectionLayoutSection {
        return createSectionLayout(groupHeight: .absolute(150), groupWidth: .absolute(150), orthogonalScrollingBehavior: .continuous)
    }

    private func createSectionLayout(groupHeight: NSCollectionLayoutDimension, groupWidth: NSCollectionLayoutDimension = .fractionalWidth(1), orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: groupHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = orthogonalScrollingBehavior
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 16, trailing: 0)

        section.visibleItemsInvalidationHandler = { items, offset, environment in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let scale = max(1.0 - (distanceFromCenter / environment.container.contentSize.width), 0.8)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [headerSupplementary]

        return section
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let noData = upComing.isEmpty && latest.isEmpty
        imgNoData.isHidden = !noData
        collectionLeagueDet.isHidden = noData
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return upComing.count
        case 1:
            return latest.count
        default:
            return teams.count
        }
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeaguesDetailsCVC", for: indexPath) as! LeaguesDetailsCVC
            cell.confinge(with: upComing[indexPath.row])
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeaguesDetailsCVC", for: indexPath) as! LeaguesDetailsCVC
            cell.confinge(with: latest[indexPath.row])
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamsCVC", for: indexPath) as! TeamsCVC
            cell.confinge(with: teams[indexPath.row])


            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LeagueDSecHed", for: indexPath) as! LeagueDSecHed
        switch indexPath.section {
        case 0:
            header.lblSectionHeader.text = "Up Coming Events"
        case 1:
            header.lblSectionHeader.text = "Latest Results"
        default:
            header.lblSectionHeader.text = "Teams"
        }
        return header
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: 30)
        cell.alpha = 0
        UIView.animate(withDuration: 0.6, delay: 0.1, options: [.curveEaseIn], animations: {
            cell.transform = .identity
            cell.alpha = 1
        }, completion: nil)
    }


}
