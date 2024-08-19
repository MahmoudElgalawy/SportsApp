//
//  LeagueDetailsTest.swift
//  SportsAppITITests
//
//  Created by Mahmoud  on 19/08/2024.
//


import XCTest

@testable import SportsAppITI

class LeagueDetailsModelTests: XCTestCase {

    var viewModel: LeagueDetailsModel!
        var coreDataManager: CoreDataManager!
        var testLeague: LeagueModel!

        override func setUp() {
            
            coreDataManager = CoreDataManager.shared
            viewModel = LeagueDetailsModel()
            
            testLeague = LeagueModel(leagueKey: 4, leagueName: "UEFA Europa League", countryKey:  Optional(1), countryName: Optional("eurocups"), leagueLogo: Optional("https://apiv2.allsportsapi.com/logo/logo_leagues/"), countryLogo: nil, leagueYear: nil)
            viewModel.league = testLeague
            viewModel.leagueID = 1
        }
    func testLoadUpcomingEvents() {
        let expectation = self.expectation(description: "Load upcoming events")

        viewModel.reloadCollectionView = {
            XCTAssertFalse(self.viewModel.upcomingEvents.isEmpty, "Upcoming events should not be empty")
            expectation.fulfill()
        }

        viewModel.loadUpcomingEvents()

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testLoadLatestEvents() {
        let expectation = self.expectation(description: "Load latest events")

        viewModel.reloadCollectionView = {
            XCTAssertFalse(self.viewModel.latestEvents.isEmpty, "Latest events should not be empty")
            expectation.fulfill()
        }

        viewModel.loadLatestEvents()

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testCheckIfFavorite() {
        viewModel.checkIfFavorite()
        XCTAssertEqual(viewModel.isFavorite, true, "The league should be marked as favorite")
    }

    func testSaveAndDeleteLeague() {
        
           viewModel.saveMovie()
           
           let fetchedLeague = coreDataManager.fetchLeague(byKey: testLeague.leagueKey)
           XCTAssertNotNil(fetchedLeague, "The league should be saved and exist in Core Data")
           
           viewModel.deleteMovie()
           
           let deletedLeague = coreDataManager.fetchLeague(byKey: testLeague.leagueKey)
           XCTAssertNil(deletedLeague, "The league should be deleted and not exist in Core Data")
       }


    override func tearDownWithError() throws {
        viewModel = nil
        coreDataManager = nil
    }
}
