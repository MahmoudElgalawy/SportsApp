//
//  LeagueDetailsTest.swift
//  SportsAppITITests
//
//  Created by Mahmoud  on 19/08/2024.
//




//import XCTest
//@testable import SportsAppITI
//import CoreData
//
//class LeagueDetailsModelTests: XCTestCase {
//
//    var viewModel: LeagueDetailsModel!
//    var mockCoreDataManager: MockCoreDataManager!
//    var mockNetworkService: MockNetworkService!
//
//    override func setUp() {
//        super.setUp()
//
//        // Initialize in-memory persistent container
//        let persistentContainer = createInMemoryPersistentContainer()
//
//        // Initialize mock Core Data Manager with the in-memory container
//        mockCoreDataManager = MockCoreDataManager(persistentContainer: persistentContainer)
//
//        // Initialize mock Network Service
//        mockNetworkService = MockNetworkService()
//
//        // Initialize ViewModel with mock dependencies
//        viewModel = LeagueDetailsModel()
//        viewModel.coreDataManager = mockCoreDataManager
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
//    func testSaveMovie() {
//        let league = LeagueModel(leagueKey: 4, leagueName: "UEFA Europa League", countryKey:  Optional(1), countryName: Optional("eurocups"), leagueLogo: Optional("https://apiv2.allsportsapi.com/logo/logo_leagues/"), countryLogo: nil, leagueYear: nil)
//
//        viewModel.league = league
//
//        viewModel.saveMovie()
//
//        XCTAssertEqual(mockCoreDataManager.storeLeagueCalledWith?.leagueKey, league.leagueKey)
//        XCTAssertEqual(mockCoreDataManager.storeLeagueCalledWith?.leagueName, league.leagueName)
//    }
//
////    func testDeleteMovie() {
////        let league = LeagueModel(leagueKey: 4, leagueName: "UEFA Europa League", countryKey:  Optional(1), countryName: Optional("eurocups"), leagueLogo: Optional("https://apiv2.allsportsapi.com/logo/logo_leagues/"), countryLogo: nil, leagueYear: nil)
////        viewModel.league = league
////
////        viewModel.deleteMovie()
////
////        XCTAssertEqual(mockCoreDataManager.deleteLeagueCalledWithModel?.leagueKey, league.leagueKey)
////        XCTAssertEqual(mockCoreDataManager.deleteLeagueCalledWithModel?.leagueName, league.leagueName)
////    }
//
////    func testCheckIfFavorite() {
////        let league = LeagueModel(leagueKey: 4, leagueName: "UEFA Europa League", countryKey:  Optional(1), countryName: Optional("eurocups"), leagueLogo: Optional("https://apiv2.allsportsapi.com/logo/logo_leagues/"), countryLogo: nil, leagueYear: nil)
////        viewModel.league = league
////        viewModel.leagueID = 4
////        mockCoreDataManager.fetchLeagueResult = league
////
////        viewModel.updateFavoriteButton = {
////            XCTAssertTrue(self.viewModel.isFavorite)
////        }
////        viewModel.checkIfFavorite()
////    }
//
//    func testLoadEventsSuccess() {
//        viewModel.leagueID = 1
//        let mockResponse = EventModelAPIResponse(success: 1, result: [
//            EventModel(homeTeamLogo: "logo1", eventHomeTeam: "team1", awayTeamLogo: "logo2", eventAwayTeam: "team2", leagueLogo: "league", eventFinalResult: "result", eventDate: "date", eventTime: "time", homeTeamKey: 1, awayTeamKey: 2)
//        ])
//
//        mockNetworkService.fetchDataCompletion = { (response: EventModelAPIResponse?, error: Error?) in
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
//        mockNetworkService.fetchDataCompletion = { (response: EventModelAPIResponse?, error: Error?) in
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
//    func testLoadUpcomingEvents() {
//        let mockResponse = EventModelAPIResponse(success: 1, result: [
//            EventModel(homeTeamLogo: "logo1", eventHomeTeam: "team1", awayTeamLogo: "logo2", eventAwayTeam: "team2", leagueLogo: "league", eventFinalResult: "result", eventDate: "date", eventTime: "time", homeTeamKey: 1, awayTeamKey: 2)
//        ])
//        mockNetworkService.fetchDataCompletion = { (response: EventModelAPIResponse?, error: Error?) in
//            XCTAssertEqual(response?.result.count, 1)
//        }
//
//        viewModel.loadUpcomingEvents()
//
//        XCTAssertEqual(viewModel.upcomingEvents.count, 1)
//    }
//
//    func testLoadLatestEvents() {
//        let mockResponse = EventModelAPIResponse(success: 1, result: [
//            EventModel(homeTeamLogo: "logo1", eventHomeTeam: "team1", awayTeamLogo: "logo2", eventAwayTeam: "team2", leagueLogo: "league", eventFinalResult: "result", eventDate: "date", eventTime: "time", homeTeamKey: 1, awayTeamKey: 2)
//        ])
//        mockNetworkService.fetchDataCompletion = { (response: EventModelAPIResponse?, error: Error?) in
//            XCTAssertEqual(response?.result.count, 1)
//        }
//
//        viewModel.loadLatestEvents()
//
//        XCTAssertEqual(viewModel.latestEvents.count, 1)
//    }
//
//    override func tearDown() {
//        viewModel = nil
//        mockCoreDataManager = nil
//        mockNetworkService = nil
//        super.tearDown()
//    }
//    func createInMemoryPersistentContainer() -> NSPersistentContainer {
//        let container = NSPersistentContainer(name: "SportsAppITI") // Replace "ModelName" with your Core Data model name
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
//class MockCoreDataManager: CoreDataManager {
//    var storeLeagueCalledWith: LeagueModel?
//    var deleteLeagueCalledWithKey: Int?
//    var deleteLeagueCalledWithModel: LeagueModel?
//    var fetchLeagueResult: LeagueModel?
//
//    override init(persistentContainer: NSPersistentContainer) {
//        super.init(persistentContainer: persistentContainer)
//    }
//
//    override func storeLeague(_ league: LeagueModel) {
//        storeLeagueCalledWith = league
//    }
//
//    override func deleteLeague(_ league: LeagueModel) {
//        deleteLeagueCalledWithModel = league
//    }
//
//    override func deleteLeague(leagueKey: Int) {
//        deleteLeagueCalledWithKey = leagueKey
//    }
//
//    override func fetchLeague(byKey leagueKey: Int) -> LeagueModel? {
//        return fetchLeagueResult
//    }
//}
//
//class MockNetworkService: NetworkRequestable {
//    var fetchDataCompletion: ((EventModelAPIResponse?, Error?) -> Void)?
//
//    func fetchData<T: Codable>(from url: SportsAPI, model: T.Type, completion: @escaping (T?, Error?) -> Void) {
//        fetchDataCompletion = { (response, error) in
//            completion(response as? T, error)
//        }
//    }
//}
//
////LeagueModel(leagueKey: 4, leagueName: "UEFA Europa League", countryKey:  Optional(1), countryName: Optional("eurocups"), leagueLogo: Optional("https://apiv2.allsportsapi.com/logo/logo_leagues/"), countryLogo: nil, leagueYear: nil)
