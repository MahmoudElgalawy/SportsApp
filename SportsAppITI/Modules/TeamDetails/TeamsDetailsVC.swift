//
//  TeamsDetailsVc.swift
//  SportsAppITI
//
//  Created by Mahmoud on 8/16/24.
//

import UIKit
import Kingfisher

class TeamsDetailsVC: UIViewController {

    @IBOutlet weak var teamsLogo: UIImageView!
    @IBOutlet weak var playersTable: UITableView!
    @IBOutlet weak var teamsName: UILabel!

    private var networkManager = NetworkService.shared
    var teamArray: [TeamModel] = []
    var allPlayers: [Player] = []
    var teamKey: Int?


    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTeamData()
    }

    private func fetchTeamData() {
        guard let teamKey = teamKey else { return }
        networkManager.fetchData(from: .getTeamDetails(teamId: teamKey), model: TeamModelApi.self) { [weak self] result, error in
            DispatchQueue.main.async {
                if error != nil {return}
                guard let self = self, let result = result else { return }
                self.teamArray = result.result
                self.allPlayers = self.teamArray.flatMap { $0.players ?? [] }
                self.updateUI()
            }
        }
    }

    private func updateUI() {
        guard let team = teamArray.first else { return }

        if let teamLogo = team.teamLogo, let url = URL(string: teamLogo) {
            teamsLogo.kf.setImage(with: url, placeholder: UIImage(named: "No_image.svg"))
        }

        teamsName.text = team.teamName
        playersTable.reloadData()
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// Extension for UITableView Delegate and DataSource
extension TeamsDetailsVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPlayers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamsTVCell", for: indexPath) as! TeamsTVCell
        cell.configure(with:allPlayers[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
}
