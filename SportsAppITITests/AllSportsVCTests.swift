//
//  AllSportsVCTests.swift
//  SportsAppITITests
//
//  Created by Engy on 8/18/24.
//

import XCTest
@testable import SportsAppITI

final class AllSportsViewModelTests: XCTestCase {

    var viewModel: AllSportsViewModel!

    override func setUpWithError() throws {
        super.setUp()
        viewModel = AllSportsViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        super.tearDown()
    }

    func testInitialSportsItems() {
        XCTAssertEqual(viewModel.sportsItems.count, 4)
        XCTAssertEqual(viewModel.sportsItems[0].titleName, "Football")
        XCTAssertEqual(viewModel.isOrthogonalLayout, true)
        XCTAssertEqual(viewModel.getImageNameForLayoutButton(), "square.grid.2x2")
        viewModel.toggleLayout()
        XCTAssertEqual(viewModel.isOrthogonalLayout, false)
        XCTAssertEqual(viewModel.getImageNameForLayoutButton(), "list.bullet")
    }

    func testSelection() {
        viewModel.handleItemSelection(at: IndexPath(row: 0, section: 0)) { internet, sportModel in
            XCTAssertEqual(sportModel.titleName, "Football")
            XCTAssertEqual(sportModel.imgName, "football")
        }
    }

    func testNavigation() {
        let exp = expectation(description: "navigation")
        viewModel.onNavigateToLeagues = { _ in
            exp.fulfill()
        }
        viewModel.navigateToLeagues(for: SportsItemModel(imgName: "", titleName: ""))
        waitForExpectations(timeout: 2)
    }
