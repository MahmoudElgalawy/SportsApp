//
//  AllLeaguesViewModelTests.swift
//  SportsAppITITests
//
//  Created by Engy on 8/20/24.
//

import XCTest
@testable import SportsAppITI

final class AllLeaguesViewModelTests: XCTestCase {

    var viewModel: AllLeaguesViewModel!
    var networkManager: NetworkRequestable!
    var coreDataManager: CoreDataManagerProtocol!
    var connectivityService: ConnectivityChecking!

    override func setUp() {
        super.setUp()
        networkManager = NetworkService.shared
        coreDataManager = CoreDataManager.shared
        connectivityService = ConnectivityService.shared

        viewModel = AllLeaguesViewModel()
    }

    override func tearDown() {
        viewModel = nil
        networkManager = nil
        coreDataManager = nil
        connectivityService = nil
        super.tearDown()
    }

    func testFetchLeaguesWhenFavorite() {
        viewModel.isFavorite = true
        let rand = Int.random(in: 1...1000)
        coreDataManager.storeLeague(LeagueModel(leagueKey: rand, leagueName: "Test League", countryKey: nil, countryName: nil, leagueLogo: nil, countryLogo: nil, leagueYear: nil))

        let expectation = self.expectation(description: "fetch favorite leagues")
        viewModel.fetchLeagues { success in
            XCTAssertTrue(success)
            XCTAssertEqual(self.viewModel.footballLeagues.last?.leagueKey, rand)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
    }

    func testFetchLeaguesWhenNotFavoriteAndSuccess() {
        viewModel.isFavorite = false
        viewModel.sportName = "football"

        let expectation = self.expectation(description: "fetch all leagues")
        viewModel.fetchLeagues { success in
            XCTAssertTrue(success)
            XCTAssertTrue(self.viewModel.footballLeagues.count != 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 6)
    }

    func testFetchLeaguesWrongSportName() {
        viewModel.isFavorite = false
        viewModel.sportName = "volley"

        let expectation = self.expectation(description: "fetch all leagues")
        viewModel.fetchLeagues { success in
            XCTAssertFalse(success)
            XCTAssertTrue(self.viewModel.footballLeagues.count == 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 6)
    }

    func testFetchLeaguesWithoutSportName() {
        viewModel.isFavorite = false
        viewModel.sportName = nil

        let expectation = self.expectation(description: "fetch leagues without sport name")

        viewModel.fetchLeagues { success in
            XCTAssertFalse(success)
            XCTAssertTrue(self.viewModel.footballLeagues.count == 0)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)
    }

    func testHandleItemSelectionWithInternetConnection() {
        viewModel.isFavorite = true
        let expectation = self.expectation(description: "handle item selection with connection")

        coreDataManager.storeLeague(LeagueModel(leagueKey: 1, leagueName: "Test League", countryKey: nil, countryName: nil, leagueLogo: nil, countryLogo: nil, leagueYear: nil))

        viewModel.fetchLeagues { _ in
            self.connectivityService.checkInternetConnection { state in
                self.viewModel.handleItemSelection(at: IndexPath(row: 0, section: 0)) { isConnected, _ in
                    XCTAssertEqual(state, isConnected)
                    expectation.fulfill()
                }
            }
        }

        waitForExpectations(timeout: 6)
    }

    func testDeleteLeague() {
        let rand = Int.random(in: 1...1000)
        coreDataManager.storeLeague(LeagueModel(leagueKey: rand, leagueName: "Test League", countryKey: nil, countryName: nil, leagueLogo: nil, countryLogo: nil, leagueYear: nil))

        viewModel.fetchLeagues { _ in
            let count = self.viewModel.footballLeagues.count
            self.viewModel.deleteLeague(at: IndexPath(row: count - 1, section: 0))
            self.viewModel.fetchLeagues { _ in
                XCTAssertEqual(self.viewModel.footballLeagues.count, count - 1)
            }
        }
    }

}
