//
//  TeamsDetailsVc.swift
//  SportsAppITI
//
//  Created by Engy on 8/16/24.
//

import UIKit
class TeamsDetailsVc:UIViewController{


    var teamKey:Int?
    var teamArray:[TeamModel] = []
    private var networkManger = NetworkService.shared


    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTeamData()


    }
    // MARK: - Network Call
    private func fetchTeamData() {
        guard let teamKey = teamKey else { return }
        networkManger.fetchData(from: .getTeamDetails(teamId: teamKey), model: TeamModelApi.self) { [weak self] result, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error fetching leagues: \(error.localizedDescription)")
                    return
                }
                self?.teamArray = result?.result ?? []
                //for testing
                self!.reloadDataAfterCallingNw()
            }
        }
    }

//for testing
    func reloadDataAfterCallingNw(){
        let allPlayers = teamArray.compactMap { $0.players }.flatMap { $0 }
        for player in allPlayers.prefix(5) {
            print(player.playerName)
            print(player.playerAge)
            print(player.playerBirthdate)
            print(player.playerCountry)

        }



    }



}
