//
//  LeagueDetailsModel.swift
//  SportsAppITI
//
//  Created by Mahmoud on 8/19/24.
//imgName: "football"

import Foundation
class LeagueDetailsModel {
    let staticArray = [
        EventModel(homeTeamLogo: "football", eventHomeTeam: "football", awayTeamLogo: "football", eventAwayTeam: "football", leagueLogo: "football", eventFinalResult: "football", eventDate: "football", eventTime: "football", homeTeamKey: 10, awayTeamKey: 19),
        EventModel(homeTeamLogo: "football", eventHomeTeam: "football", awayTeamLogo: "football", eventAwayTeam: "football", leagueLogo: "football", eventFinalResult: "football", eventDate: "football", eventTime: "football", homeTeamKey: 10, awayTeamKey: 19),
        

    ]

    var leagueID: Int!
    var leagueTitle: String = " "
    var league: LeagueModel!
    var isFavorite = true
    var errorCount = 0
    var networkManager = NetworkService.shared
    var coreDataManager = CoreDataManager.shared
    var upcomingEvents = [EventModel]()
    var teams = [TeamModel]()
    var latestEvents = [EventModel]() {
        didSet { updateTeams() }
    }
    var handelErrorVC: ()->() = {}
    var bindTeamsDetailsVC: ()->() = {}
    var setUpActivityIndicator:()->() = {}
    var reloadCollectionView:()->() = {}
    var updateFavoriteButton:()->() = {}
    var showBackImage:(Bool)->() = {_ in }



     func updateTeams() {
        teams = latestEvents.map { event in
            TeamModel(teamKey: event.homeTeamKey,
                      teamName: event.eventHomeTeam,
                      teamLogo: event.homeTeamLogo,
                      players: []
                     )
        }
         reloadCollectionView()
    }

     func handleErrors() {
        errorCount += 1
        if errorCount == 2 {
            let hasErrors = upcomingEvents.isEmpty && latestEvents.isEmpty
            showBackImage(hasErrors)

        }
    }
    func saveMovie() {
        print("Saving league...")
        coreDataManager.storeLeague(league)
        print("League saved successfully.")
    }

    func deleteMovie() {
        print("Deleting league...")
        coreDataManager.deleteLeague(league)
        print("League deleted successfully.")
    }

    func checkIfFavorite() {
        guard let league = league else { return }
        let fetchedLeague = coreDataManager.fetchLeague(byKey: league.leagueKey)
        isFavorite = fetchedLeague != nil
        self.updateFavoriteButton()
    }

    // MARK: - Data Loading Methods
     func loadEvents(endpoint: SportsAPI, completion: @escaping ([EventModel]?, Error?) -> Void) {
        networkManager.fetchData(from: endpoint, model: EventModelAPIResponse.self) { [weak self] results, error in
            guard let self = self else { return }
            self.setUpActivityIndicator()
            if let error = error {
                print("Error fetching events: \(error)")
                completion(nil, error)
                return
            }
            guard let results = results else {
                print("No data received")
                completion(nil, error)
                return
            }
            DispatchQueue.main.async {
                let events = results.result
                if !events.isEmpty {
                    completion(events, nil)
                } else {
                    completion(nil, error)
                    print("No events found.")
                }
                self.reloadCollectionView()
            }
        }
    }

     func loadUpcomingEvents() {
        loadEvents(endpoint: .getUpcomingEvents(leagueId: leagueID, fromDate: .now, toDate: .upcoming)) { events, error in
            if error != nil {
                self.handleErrors()
                return
            }
            self.upcomingEvents = events!
        }
    }

     func loadLatestEvents() {
        loadEvents(endpoint: .getLatestResults(leagueId: leagueID, fromDate: .passed, toDate: .now)) { events, error in
            if error != nil {
                self.handleErrors()
                return
            }
            self.latestEvents = events!
        }
    }





}
