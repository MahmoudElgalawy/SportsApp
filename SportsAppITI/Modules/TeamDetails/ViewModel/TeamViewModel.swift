//
//  TeamViewModel.swift
//  SportsAppITI
//
//  Created by Mahmoud  on 18/08/2024.
//
import Foundation
class TeamViewModel {
    private var networkManager = NetworkService.shared
    var teamKey: Int?
    var teamArray: [TeamModel] = []
    var allPlayers: [Player] = []
    var bindTeamsDetailsVC: ()->() = {}


    func fetchTeamData() {
        guard let teamKey = teamKey else { return }
        networkManager.fetchData(from: .getTeamDetails(teamId: teamKey), model: TeamModelApi.self) { [weak self] result, error in
            DispatchQueue.main.async {
                if error != nil {return}
                guard let self = self, let result = result else { return }
                self.teamArray = result.result
                self.allPlayers = self.teamArray.flatMap { $0.players ?? [] }
                self.bindTeamsDetailsVC()
            }
        }
    }
}

