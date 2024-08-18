//
//  AllSportsViewModelTests.swift
//  SportsAppITITests
//
//  Created by Engy on 8/18/24.


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
    }

//    func testToggleLayout() {
//        XCTAssertEqual(viewModel.layoutType, .orthogonal)
//        viewModel.toggleLayout()
//        XCTAssertEqual(viewModel.layoutType, .list)
//        viewModel.toggleLayout()
//        XCTAssertEqual(viewModel.layoutType, .orthogonal)
//    }
}
