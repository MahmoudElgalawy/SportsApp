//
//  TeamsDetailsVc.swift
//  SportsAppITI
//
//  Created by Mahmoud on 8/16/24.
//

import UIKit
import Kingfisher


class TeamsDetailsVc:UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var teamsLogo: UIImageView!
    
    @IBOutlet weak var playersTable: UITableView!
    @IBOutlet weak var teamsName: UILabel!
    
    var teamArray: [TeamModel] = []
        var allPlayers = [Player]()
        var teamCoaches = [Coach]()
        var teamKey: Int?
        private var networkManager = NetworkService.shared

        override func viewDidLoad() {
            super.viewDidLoad()

            playersTable.delegate = self
            playersTable.dataSource = self
            configureTableView()
            fetchTeamData()
        }

        private func fetchTeamData() {
            guard let teamKey = teamKey else { return }

            networkManager.fetchData(from: .getTeamDetails(teamId: teamKey), model: TeamModelApi.self) { [weak self] result, error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error fetching teams: \(error.localizedDescription)")
                        return
                    }

                    guard let self = self, let result = result else { return }
                    self.teamArray = result.result 

                    // Extract players and coaches
                    self.allPlayers = self.teamArray.flatMap { $0.players ?? [] }
                    self.teamCoaches = self.teamArray.flatMap { $0.coaches ?? [] }

                    // Update UI
                    self.updateUI()
                }
            }
        }

        private func updateUI() {
            if let team = teamArray.first {
                if let teamLogo = team.teamLogo, let url = URL(string: teamLogo) {
                    teamsLogo.kf.setImage(with: url, placeholder: UIImage(named: "No_image.svg"))
                }
                teamsName.text = team.teamName
            }

            playersTable.reloadData()
        }

        func configureTableView() {
            playersTable.register(UINib(nibName: String(describing: TeamsTVC.self), bundle: nil), forCellReuseIdentifier: String(describing: TeamsTVC.self))
            playersTable.register(UINib(nibName: String(describing: coachCell.self), bundle: nil), forCellReuseIdentifier: String(describing: coachCell.self))
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return allPlayers.count + teamCoaches.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.row < teamCoaches.count {
                let cell = playersTable.dequeueReusableCell(withIdentifier: String(describing: coachCell.self), for: indexPath) as! coachCell
                let coach = teamCoaches[indexPath.row]
                cell.configure(coach: coach)
                return cell
            } else {
                let cell = playersTable.dequeueReusableCell(withIdentifier: String(describing: TeamsTVC.self), for: indexPath) as! TeamsTVC
                let player = allPlayers[indexPath.row - teamCoaches.count]
                cell.configureCell(data: player)
                return cell
            }
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }

        @IBAction func backButton(_ sender: Any) {
            dismiss(animated: true, completion: nil)
        }
    }


