////
////  LeagueDetailsTest.swift
////  SportsAppITITests
////
////  Created by Engy on 8/20/24.
////
//
//
//import XCTest
//@testable import SportsAppITI
//import CoreData
//
//class LeagueDetailsModelTests: XCTestCase {
//
//    var viewModel: LeagueDetailsModel!
//    var coreDataManager: CoreDataManager!
//    var mockNetworkService: MockNetworkService!
//
//    override func setUp() {
//        super.setUp()
//
//        coreDataManager = CoreDataManager(persistentContainer: createInMemoryPersistentContainer())
//
//        mockNetworkService = MockNetworkService()
//
//        viewModel = LeagueDetailsModel()
//    }
//
//    func testUpdateTeams() {
//        viewModel.latestEvents = [
//            EventModel(homeTeamLogo: "logo1", eventHomeTeam: "team1", awayTeamLogo: "logo2", eventAwayTeam: "team2", leagueLogo: "league", eventFinalResult: "result", eventDate: "date", eventTime: "time", homeTeamKey: 1, awayTeamKey: 2)
//        ]
//        viewModel.reloadCollectionView = {
//            XCTAssertEqual(self.viewModel.teams.count, 1)
//            XCTAssertEqual(self.viewModel.teams.first?.teamKey, 1)
//        }
//        viewModel.updateTeams()
//    }
//
//    func testHandleErrors() {
//        viewModel.upcomingEvents = []
//        viewModel.latestEvents = []
//        viewModel.errorCount = 1
//
//        viewModel.showBackImage = { hasErrors in
//            XCTAssertTrue(hasErrors)
//        }
//        viewModel.handleErrors()
//    }
//
////    func testSaveLeague() {
////        let league = LeagueModel(leagueKey: 4, leagueName: "UEFA Europa League", countryKey: 1, countryName: "eurocups", leagueLogo: "https://apiv2.allsportsapi.com/logo/logo_leagues/", countryLogo: nil, leagueYear: nil)
////        viewModel.league = league
////
////        viewModel.saveLeague()
////
////        let fetchedLeague = coreDataManager.fetchLeague(byKey: league.leagueKey)
////        XCTAssertEqual(fetchedLeague, league)
////    }
//
//    func testDeleteLeague() {
//        let league = LeagueModel(leagueKey: 4, leagueName: "UEFA Europa League", countryKey: 1, countryName: "eurocups", leagueLogo: "https://apiv2.allsportsapi.com/logo/logo_leagues/", countryLogo: nil, leagueYear: nil)
//        viewModel.league = league
//
//        viewModel.deleteLeague()
//
//        let deletedLeague = coreDataManager.fetchLeague(byKey: league.leagueKey)
//        XCTAssertNil(deletedLeague)
//    }
//
//    func testLoadEventsSuccess() {
//        let mockResponse = EventsModel(success: 1, result: [
//            EventModel(homeTeamLogo: "logo1", eventHomeTeam: "team1", awayTeamLogo: "logo2", eventAwayTeam: "team2", leagueLogo: "league", eventFinalResult: "result", eventDate: "date", eventTime: "time", homeTeamKey: 1, awayTeamKey: 2)
//        ])
//
//        mockNetworkService.fetchDataCompletion = { (response: EventsModel?, error: Error?) in
//            XCTAssertNotNil(response)
//            XCTAssertEqual(response?.result.count, 1)
//        }
//
//        viewModel.loadEvents(endpoint: .getUpcomingEvents(leagueId: 1, fromDate: .now, toDate: .upcoming)) { events, error in
//            XCTAssertNotNil(events)
//            XCTAssertNil(error)
//        }
//    }
//
//    func testLoadEventsFailure() {
//        mockNetworkService.fetchDataCompletion = { (response: EventsModel?, error: Error?) in
//            XCTAssertNil(response)
//            XCTAssertNotNil(error)
//        }
//
//        viewModel.loadEvents(endpoint: .getUpcomingEvents(leagueId: 1, fromDate: .now, toDate: .upcoming)) { events, error in
//            XCTAssertNil(events)
//            XCTAssertNotNil(error)
//        }
//    }
//
////    func testLoadUpcomingEvents() {
////        let mockResponse = EventsModel(success: 1, result: [
////            EventModel(homeTeamLogo: "logo1", eventHomeTeam: "team1", awayTeamLogo: "logo2", eventAwayTeam: "team2", leagueLogo: "league", eventFinalResult: "result", eventDate: "date", eventTime: "time", homeTeamKey: 1, awayTeamKey: 2)
////        ])
////
////        mockNetworkService.fetchDataCompletion = { (response: EventsModel?, error: Error?) in
////            XCTAssertEqual(response?.result.count, 1)
////        }
////
////        viewModel.loadUpcomingEvents()
////
////        XCTAssertEqual(viewModel.upcomingEvents.count, 1)
////    }
//
////    func testLoadLatestEvents() {
////        let mockResponse = EventsModel(success: 1, result: [
////            EventModel(homeTeamLogo: "logo1", eventHomeTeam: "team1", awayTeamLogo: "logo2", eventAwayTeam: "team2", leagueLogo: "league", eventFinalResult: "result", eventDate: "date", eventTime: "time", homeTeamKey: 1, awayTeamKey: 2)
////        ])
////
////        mockNetworkService.fetchDataCompletion = { (response: EventsModel?, error: Error?) in
////            XCTAssertEqual(response?.result.count, 1)
////        }
////
////        viewModel.loadLatestEvents()
////
////        XCTAssertEqual(viewModel.latestEvents.count, 1)
////    }
//
//    override func tearDown() {
//        viewModel = nil
//        mockNetworkService = nil
//        coreDataManager = nil
//        super.tearDown()
//    }
//
//    func createInMemoryPersistentContainer() -> NSPersistentContainer {
//        let container = NSPersistentContainer(name: "SportsAppITI") // Replace with your Core Data model name
//        let description = NSPersistentStoreDescription()
//        description.type = NSInMemoryStoreType
//        container.persistentStoreDescriptions = [description]
//        container.loadPersistentStores { description, error in
//            if let error = error {
//                fatalError("Failed to load in-memory store: \(error)")
//            }
//        }
//        return container
//    }
//}
//
//
//class MockNetworkService: NetworkRequestable {
//    func fetchData<T>(from url: SportsAppITI.SportsAPI, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
//        fetchDataCompletion = { (response, error) in
//            completion(response as? T as! Result<T, any Error>)
//        }
//    }
//
//    var fetchDataCompletion: ((EventsModel?, Error?) -> Void)?
//
//}
