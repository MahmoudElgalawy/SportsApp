//
//  LeaguesViewModel.swift
//  SportsAppITI
//
//  Created by Engy on 8/18/24.
//

import Foundation

class AllLeaguesViewModel {

    // MARK: - Properties
    private let networkManager = NetworkService.shared
    private let coreDataManager = CoreDataManager.shared
    private(set) var footballLeagues = [LeagueModel]()
    var sportName: String?
    var isFavorite: Bool = true


    // MARK: - Fetch Data
    func fetchLeagues(completion: @escaping (Bool) -> Void) {
        if isFavorite {
            fetchFavoriteLeagues(completion: completion)
        } else {
            fetchAllLeagues(completion: completion)
        }
    }

    private func fetchFavoriteLeagues(completion: @escaping (Bool) -> Void) {
        self.footballLeagues = coreDataManager.fetchLeagues()
        completion(!footballLeagues.isEmpty)
    }

    private func fetchAllLeagues(completion: @escaping (Bool) -> Void) {
        guard let sportName = sportName else {
            completion(false)
            return
        }
        networkManager.fetchData(from: .getAllLeagues(sportsName: sportName), model: LeaguesModel.self) { [weak self] result, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error fetching leagues: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                self?.footballLeagues = result?.result ?? []
                completion(!(self?.footballLeagues.isEmpty ?? false))
            }
        }
    }


    func handleItemSelection(at indexPath: IndexPath, completion: @escaping (Bool, LeagueModel) -> Void) {
        let selectedItem = footballLeagues[indexPath.row]
        ConnectivityService.shared.checkInternetConnection { isConnected in
            completion(isConnected, selectedItem)
        }
    }

    // MARK: - Manage Leagues
    func deleteLeague(at indexPath: IndexPath) {
        let leagueToDelete = footballLeagues[indexPath.row]
        footballLeagues.remove(at: indexPath.row)
        coreDataManager.deleteLeague(byKey: leagueToDelete.leagueKey)
    }
}
