//
//  LeagueDetailsModel.swift
//  SportsAppITI
//
//  Created by Mahmoud on 8/19/24.

import Foundation

class LeagueDetailsModel {

    // MARK: - Properties
    var leagueID: Int!
    var leagueTitle: String = " "
    var league: LeagueModel!
    var isFavorite = true
    private var errorCount = 0
    private let networkManager = NetworkService.shared
    private let coreDataManager = CoreDataManager.shared

    var upcomingEvents = [EventModel]()
    var teams = [TeamModel]()
    var latestEvents = [EventModel]() {
        didSet { updateTeams() }
    }

    // MARK: - Callbacks
    var handleErrorVC: () -> Void = {}
    var bindTeamsDetailsVC: () -> Void = {}
    var setUpActivityIndicator: () -> Void = {}
    var reloadCollectionView: () -> Void = {}
    var updateFavoriteButton: () -> Void = {}
    var showBackImage: (Bool) -> Void = { _ in }

    // MARK: - Update Methods
    private func updateTeams() {
        teams = latestEvents.map {
            TeamModel(teamKey: $0.homeTeamKey,
                      teamName: $0.eventHomeTeam,
                      teamLogo: $0.homeTeamLogo,
                      players: [])
        }
        reloadCollectionView()
    }

    private func handleErrors() {
        errorCount += 1
        if errorCount >= 2 && upcomingEvents.isEmpty && latestEvents.isEmpty {
            showBackImage(true)
        }
    }

    // MARK: - Core Data Management
    func saveLeague() {
        print("Saving league")
        coreDataManager.storeLeague(league)
        print("League saved successfully.")
    }

    func deleteLeague() {
        print("Deleting league")
        coreDataManager.deleteLeague(league)
        print("League deleted successfully.")
    }

    func checkIfFavorite() {
        guard let league = league else { return }
        isFavorite = coreDataManager.fetchLeague(byKey: league.leagueKey) != nil
        updateFavoriteButton()
    }

    // MARK: - Data Loading Methods
     func loadEvents(endpoint: SportsAPI, completion: @escaping ([EventModel]?, Error?) -> Void) {
        networkManager.fetchData(from: endpoint, model: EventsModel.self) { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async { self.setUpActivityIndicator() }

            switch result {
            case .success(let eventsModel):
                let events = eventsModel.result
                DispatchQueue.main.async {
                    completion(events.isEmpty ? nil : events, events.isEmpty ? nil : nil)
                    if events.isEmpty { print("No events found.") }
                    self.reloadCollectionView()
                }

            case .failure(let error):
                print("Error fetching events: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil, error)
                    self.reloadCollectionView()
                }
            }
        }
    }

     func loadUpcomingEvents() {
        loadEvents(endpoint: .getUpcomingEvents(leagueId: leagueID, fromDate: .now, toDate: .upcoming)) { [weak self] events, error in
            guard let self = self else { return }
            if error != nil {
                self.handleErrors()
                return
            }
            self.upcomingEvents = events ?? []
        }
    }

     func loadLatestEvents() {
        loadEvents(endpoint: .getLatestResults(leagueId: leagueID, fromDate: .passed, toDate: .now)) { [weak self] events, error in
            guard let self = self else { return }
            if error != nil {
                self.handleErrors()
                return
            }
            self.latestEvents = events ?? []
        }
    }
}
