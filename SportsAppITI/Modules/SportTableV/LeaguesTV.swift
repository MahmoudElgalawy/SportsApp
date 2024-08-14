//
//  LeagueVC.swift
//  SportsAppITI
//
//  Created by Engy on 8/11/24.
//

import UIKit

class LeaguesTV: UIViewController {

    // MARK: - Properties
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let networkManager = NWService.shared
    private var footballLeagues: [LeagueModel] = []
    var sportName: String?

    // MARK: - Outlets
    @IBOutlet private var leagueTableView: UITableView!
    @IBOutlet var noDataImg: UIImageView!


    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        fetchAllLeagues()
    }

    // MARK: - Setup Methods

    private func setupActivityIndicator() {
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }

    // MARK: - Network Call
    private func fetchAllLeagues() {
        activityIndicator.startAnimating()
        networkManager.getAllData(sportName: .getAllLeagues(sportsName: sportName!), model: LeagueModelAPI.self) { [weak self] result, error in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                if let error = error {
                    print("Error fetching leagues: \(error.localizedDescription)")
                    return
                }
                guard let leagues = result?.result else { return }
                self?.footballLeagues = leagues
                self?.leagueTableView.reloadData()
            }
        }
    }

}

// MARK: - UITableViewDataSource
extension LeaguesTV: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return footballLeagues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SportTvCell else {
            return UITableViewCell()
        }
        cell.configure(with: footballLeagues[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LeaguesTV: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetails", sender:indexPath.row)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails"{
            if let detailsVC = segue.destination as? LeagueDetailsVC {
                detailsVC.leagueID = footballLeagues[sender as! Int].leagueKey
                detailsVC.leagueTitle = footballLeagues[sender as! Int].leagueName

            }

        }
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: 30)
        cell.alpha = 0
        UIView.animate(withDuration: 0.6, delay: 0.1, options: [.curveEaseIn], animations: {
            cell.transform = .identity
            cell.alpha = 1
        }, completion: nil)
    }   
}



