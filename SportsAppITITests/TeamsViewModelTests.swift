//
//  TeamsViewModelTests.swift
//  SportsAppITITests
//
//  Created by Engy on 8/20/24.
//

import XCTest
@testable import SportsAppITI

final class TeamsViewModelTests: XCTestCase {

    var viewModel: TeamsViewModel!

    override func setUpWithError() throws {
        viewModel = TeamsViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testFetchTeamDetails() {
        viewModel.teamKey = 10
        let expectation = expectation(description: "Fetch Team Details")
        viewModel.bindTeamsDetailsVC = {
            XCTAssertEqual(self.viewModel.teamArray.count, 1)
            expectation.fulfill()
        }
        viewModel.fetchTeamData()
        waitForExpectations(timeout: 5)
    }
}
