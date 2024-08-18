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
        super.setUp()

        persistentContainer = NSPersistentContainer(name: "SportsAppITI")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [description]
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }

        coreDataManager = CoreDataManager(persistentContainer: persistentContainer)
    }

    override func tearDownWithError() throws {
        coreDataManager = nil
        persistentContainer = nil
        super.tearDown()
    }

    func testStoreLeague() {
        let league = LeagueModel(
            leagueKey: 1,
            leagueName: "Premier League",
            countryKey: 44,
            countryName: "England",
            leagueLogo: "logo_url",
            countryLogo: "country_logo_url",
            leagueYear: "2024"
        )

        coreDataManager.storeLeague(league)

        let fetchedLeagues = coreDataManager.fetchLeagues()
        XCTAssertEqual(fetchedLeagues.count, 1)
        XCTAssertEqual(fetchedLeagues.first?.leagueName, "Premier League")
    }

    func testFetchLeagues() {
        let league1 = LeagueModel(
            leagueKey: 1,
            leagueName: "Premier League",
            countryKey: 44,
            countryName: "England",
            leagueLogo: "logo_url",
            countryLogo: "country_logo_url",
            leagueYear: "2024"
        )
        let league2 = LeagueModel(
            leagueKey: 2,
            leagueName: "La Liga",
            countryKey: 34,
            countryName: "Spain",
            leagueLogo: "logo_url",
            countryLogo: "country_logo_url",
            leagueYear: "2024"
        )

        coreDataManager.storeLeague(league1)
        coreDataManager.storeLeague(league2)

        let fetchedLeagues = coreDataManager.fetchLeagues()
        XCTAssertEqual(fetchedLeagues.count, 2)
        XCTAssertTrue(fetchedLeagues.contains { $0.leagueName == "Premier League" })
        XCTAssertTrue(fetchedLeagues.contains { $0.leagueName == "La Liga" })
    }

    func testDeleteLeague() {
        let league = LeagueModel(
            leagueKey: 1,
            leagueName: "Premier League",
            countryKey: 44,
            countryName: "England",
            leagueLogo: "logo_url",
            countryLogo: "country_logo_url",
            leagueYear: "2024"
        )

        coreDataManager.storeLeague(league)
        coreDataManager.deleteLeague(leagueKey: league.leagueKey)

        let fetchedLeagues = coreDataManager.fetchLeagues()
        XCTAssertTrue(fetchedLeagues.isEmpty)
    }

    func testFetchLeagueByKey() {
        let league = LeagueModel(
            leagueKey: 1,
            leagueName: "Premier League",
            countryKey: 44,
            countryName: "England",
            leagueLogo: "logo_url",
            countryLogo: "country_logo_url",
            leagueYear: "2024"
        )

        coreDataManager.storeLeague(league)

        let fetchedLeague = coreDataManager.fetchLeague(byKey: league.leagueKey)
        XCTAssertNotNil(fetchedLeague)
        XCTAssertEqual(fetchedLeague?.leagueName, "Premier League")
    }
}
