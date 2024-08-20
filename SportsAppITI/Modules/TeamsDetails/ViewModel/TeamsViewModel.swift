//
//  TeamViewModel.swift
//  SportsAppITI
//
//  Created by Mahmoud  on 18/08/2024.
//
import Foundation
class TeamsViewModel {
    private var networkManager = NetworkService.shared
    var teamKey: Int?
    var teamArray: [TeamModel] = []
    var allPlayers: [Player] = []
    var bindTeamsDetailsVC: ()->() = {}


    func fetchTeamData() {
        guard let teamKey = teamKey else { return }

        networkManager.fetchData(from: .getTeamDetails(teamId: teamKey), model: TeamsModel.self) { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                switch result {
                case .success(let teamsModel):
                    self.teamArray = teamsModel.result
                    self.allPlayers = self.teamArray.flatMap { $0.players ?? [] }
                    self.bindTeamsDetailsVC()

                case .failure(let error):
                    print("Error fetching team data: \(error.localizedDescription)")
                }
            }
        }
    }
}

