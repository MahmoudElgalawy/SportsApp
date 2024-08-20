//
//  LeagueDetailsTest.swift
//  SportsAppITITests
//
//  Created by Engy on 8/20/24.
//
import XCTest
@testable import SportsAppITI

final class LeagueDetailsModelTests: XCTestCase {

    var viewModel: LeagueDetailsModel!

    override func setUpWithError() throws {
        viewModel = LeagueDetailsModel()
        viewModel.leagueID = 4
        viewModel.league = LeagueModel(leagueKey: viewModel.leagueID, leagueName: "Test League", countryKey: nil, countryName: nil, leagueLogo: nil, countryLogo: nil, leagueYear: nil)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testAddFavorite() {
        //viewModel.deleteLeague()
       // viewModel.checkIfFavorite()
        //XCTAssertFalse(viewModel.isFavorite)
        viewModel.saveLeague()
        viewModel.checkIfFavorite()
        XCTAssertTrue(viewModel.isFavorite)
    }

    func testLoadUpcomingEvents() {
        let expectation = XCTestExpectation(description: "Load Upcoming Events")
        viewModel.reloadCollectionView = {
            XCTAssertNotEqual(self.viewModel.upcomingEvents.count, 0)
            expectation.fulfill()
        }
        viewModel.loadUpcomingEvents()
        wait(for: [expectation], timeout: 5)
    }

    func testLoadLatestEvents() {
        let expectation = XCTestExpectation(description: "Load latest Events")
        viewModel.reloadCollectionView = {
            XCTAssertNotEqual(self.viewModel.latestEvents.count, 0)
            expectation.fulfill()
        }
        viewModel.loadLatestEvents()
        wait(for: [expectation], timeout: 5)
    }
}
