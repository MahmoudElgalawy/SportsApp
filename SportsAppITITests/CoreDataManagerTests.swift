//
//  CoreDataManagerTests.swift
//  SportsAppITITests
//
//  Created by Engy on 8/18/24.
//
import XCTest
import CoreData
@testable import SportsAppITI

final class CoreDataManagerTests: XCTestCase {

    var coreDataManager: CoreDataManager!
    var persistentContainer: NSPersistentContainer!

    override func setUpWithError() throws {
        persistentContainer = NSPersistentContainer(name: "SportsAppITI")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [description]
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Failed to load in-memory store: \(error)")
            }
        }

        coreDataManager = CoreDataManager(persistentContainer: persistentContainer)
    }

    override func tearDownWithError() throws {
        coreDataManager = nil
        persistentContainer = nil
    }

    func testStoreLeague() throws {
        let league = LeagueModel(leagueKey: 1, leagueName: "Premier League", countryKey: 44, countryName: "England", leagueLogo: "logo.png", countryLogo: "country.png", leagueYear: "2024")
        coreDataManager.storeLeague(league)
        let fetchedLeagues = coreDataManager.fetchLeagues()
        XCTAssertEqual(fetchedLeagues.count, 1, "League was not stored correctly")
        XCTAssertEqual(fetchedLeagues.first?.leagueKey, league.leagueKey, "Stored league key does not match")
    }

    func testFetchLeagues() throws {
        let league = LeagueModel(leagueKey: 2, leagueName: "La Liga", countryKey: 34, countryName: "Spain", leagueLogo: "logo2.png", countryLogo: "country2.png", leagueYear: "2024")
        coreDataManager.storeLeague(league)
        let fetchedLeagues = coreDataManager.fetchLeagues()
        XCTAssertEqual(fetchedLeagues.count, 1, "Fetch leagues returned incorrect number of leagues")
        XCTAssertEqual(fetchedLeagues.first?.leagueKey, league.leagueKey, "Fetched league key does not match")
    }

    func testDeleteLeagueByKey() throws {
        let league = LeagueModel(leagueKey: 20, leagueName: "Serie A", countryKey: 39, countryName: "Italy", leagueLogo: "logo3.png", countryLogo: "country3.png", leagueYear: "2024")
        coreDataManager.storeLeague(league)
        
        coreDataManager.deleteLeague(leagueKey: league.leagueKey)
        let fetchedLeagues = coreDataManager.fetchLeagues()
        XCTAssertTrue(fetchedLeagues.isEmpty, "League was not deleted")
    }
    func testDeleteLeague() throws {
        let league = LeagueModel(leagueKey: 20, leagueName: "Serie A", countryKey: 39, countryName: "Italy", leagueLogo: "logo3.png", countryLogo: "country3.png", leagueYear: "2024")
        coreDataManager.storeLeague(league)
        coreDataManager.deleteLeague(league)
        let fetchedLeagues = coreDataManager.fetchLeagues()
        XCTAssertTrue(fetchedLeagues.isEmpty, "League was not deleted")
    }

    func testFetchLeagueByKey() throws {
        let league = LeagueModel(leagueKey: 4, leagueName: "Bundesliga", countryKey: 49, countryName: "Germany", leagueLogo: "logo4.png", countryLogo: "country4.png", leagueYear: "2024")
        coreDataManager.storeLeague(league)

        // Act
        let fetchedLeague = coreDataManager.fetchLeague(byKey: league.leagueKey)

        // Assert
        XCTAssertNotNil(fetchedLeague, "League should be fetched")
        XCTAssertEqual(fetchedLeague?.leagueKey, league.leagueKey, "Fetched league key does not match")
    }
}
