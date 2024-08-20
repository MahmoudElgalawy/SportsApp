//
//  TeamsDetailsVc.swift
//  SportsAppITI
//
//  Created by Mahmoud on 8/16/24.
//

import UIKit
import Kingfisher

class TeamsDetailsVC: UIViewController {
    let viewModel = TeamViewModel()

  @IBOutlet var playerBackImg: UIImageView!
    @IBOutlet weak var teamsLogo: UIImageView!
    @IBOutlet weak var playersTable: UITableView!
    @IBOutlet weak var teamsName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchTeamData()
        viewModel.bindTeamsDetailsVC = {
            self.updateUI()
        }
    }

    private func updateUI() {
        guard let team = viewModel.teamArray.first else { return }
        if let teamLogo = team.teamLogo, let url = URL(string: teamLogo) {
            teamsLogo.kf.setImage(with: url, placeholder: UIImage(named: "No_image.svg"))
        }
        teamsName.text = team.teamName
        teamsLogo.layer.cornerRadius = 8


        playersTable.reloadData()
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// Extension for UITableView Delegate and DataSource
extension TeamsDetailsVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.allPlayers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamsTVCell", for: indexPath) as! TeamsTVCell
        cell.configure(with:viewModel.allPlayers[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.animateSlideAndFadeIn()
    }
}
