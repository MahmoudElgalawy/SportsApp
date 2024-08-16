//
//  TeamsDetailsVc.swift
//  SportsAppITI
//
//  Created by Engy on 8/16/24.
//

import UIKit
import Kingfisher


class TeamsDetailsVc:UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var teamsLogo: UIImageView!
    
    @IBOutlet weak var playersTable: UITableView!
    @IBOutlet weak var teamsName: UILabel!
    var team:TeamModel!
   var teamPlayers = [Player]()
   var teamCoaches = [Coach]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let teamLogo = team.teamLogo else{return}
         let url = URL(string: teamLogo)
        teamsLogo.kf.setImage(with: url,placeholder: UIImage(named: "No_image.svg"))
        teamsName.text = team.teamName
        
        playersTable.delegate = self
        playersTable.dataSource = self
        configureTableView()
        
        playersTable.reloadData()
    }
    
    func uploadPlayersandCoaches() {
       
//        guard let players = team.players else{
//            print("No players found!")
//            return}
//        teamPlayers = players
//        guard let coaches = team.coaches else{
//            print("No coaches found!")
//            return}
//        teamCoaches = coaches
//        
//        print(" players \(teamPlayers)")
//        print(" coaches \(teamCoaches)")
        
    }

    
    func configureTableView() {
        playersTable.register(UINib(nibName: String(describing: TeamsTVC.self), bundle: nil), forCellReuseIdentifier: String(describing: TeamsTVC.self))
        playersTable.register(UINib(nibName: String(describing: coachCell.self), bundle: nil), forCellReuseIdentifier: String(describing: coachCell.self))
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  teamPlayers.count + teamCoaches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < teamCoaches.count {
                print("Configuring coach cell for row \(indexPath.row)")
                let cell = playersTable.dequeueReusableCell(withIdentifier: String(describing: coachCell.self)) as! coachCell
                cell.configure(coach: teamCoaches[indexPath.row])
                return cell
            } else {
                print("Configuring player cell for row \(indexPath.row)")
                let cell = playersTable.dequeueReusableCell(withIdentifier: String(describing: TeamsTVC.self)) as! TeamsTVC
                let player = teamPlayers[indexPath.row - teamCoaches.count]
                cell.configureCell(data: player)
                return cell
            }
            }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
}


