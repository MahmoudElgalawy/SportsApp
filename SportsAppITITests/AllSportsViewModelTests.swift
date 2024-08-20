//
//  AllSportsViewModelTests.swift
//  SportsAppITITests
//
//  Created by Engy on 8/18/24.


import XCTest
@testable import SportsAppITI

class AllSportsViewModelFunctionalityTests: XCTestCase {

    var viewModel: AllSportsViewModel!

    override func setUp() {
        super.setUp()
        viewModel = AllSportsViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testToggleLayoutFunctionality() {
        let initialLayout = viewModel.isOrthogonalLayout
        viewModel.toggleLayout()
        XCTAssertNotEqual(viewModel.isOrthogonalLayout, initialLayout, "The layout should be toggled.")
    }

    func testGetImageNameForLayoutButtonFunctionality() {
        let expectedGridIcon = "square.grid.2x2"
        let expectedListIcon = "list.bullet"
        let initialIcon = viewModel.getImageNameForLayoutButton()
        XCTAssertEqual(initialIcon, expectedGridIcon, "The initial icon should be \(expectedGridIcon).")

        viewModel.toggleLayout()
        let toggledIcon = viewModel.getImageNameForLayoutButton()

        XCTAssertEqual(toggledIcon, expectedListIcon, "The toggled icon should be \(expectedListIcon).")
    }

    func testHandleItemSelectionFunctionality() {
        let indexPath = IndexPath(row: 0, section: 0)
        let expectedItem = viewModel.sportsItems[indexPath.row]
        let expectation = self.expectation(description: "Completion handler called")
        viewModel.handleItemSelection(at: indexPath) { (isConnected, selectedItem) in
            XCTAssertTrue(isConnected, "Internet should be connected.")
            XCTAssertEqual(selectedItem.titleName, expectedItem.titleName, "Selected item should match the expected item.")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testNavigateToLeaguesFunctionality() {
        let expectedItem = viewModel.sportsItems[0]
        var navigatedItem: SportsItemModel?

        viewModel.onNavigateToLeagues = { selectedItem in
            navigatedItem = selectedItem
        }
        viewModel.navigateToLeagues(for: expectedItem)
        XCTAssertEqual(navigatedItem?.titleName, expectedItem.titleName, "Navigated item should be the expected item.")
    }
}

class MockConnectivityService: ConnectivityService {
    private let isConnected: Bool = true
    override func checkInternetConnection(completion: @escaping (Bool) -> Void) {
        completion(isConnected)
    }
}
