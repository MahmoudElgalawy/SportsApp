//
//  AllSportsVCTests.swift
//  SportsAppITITests
//
//  Created by Engy on 8/18/24.
//

import XCTest
@testable import SportsAppITI

final class AllSportsVCTests: XCTestCase {

    var viewController: AllSportsVC!
    var mockViewModel: MockAllSportsViewModel!
    var mockNetworkService: MockNetworkService!
    var mockConnectivityService: MockConnectivityService!

    override func setUpWithError() throws {
        super.setUp()
        mockViewModel = MockAllSportsViewModel()
        mockNetworkService = MockNetworkService()
        mockConnectivityService = MockConnectivityService()
        viewController = AllSportsVC(viewModel: mockViewModel, networkManager: mockNetworkService, connectivityChecking: mockConnectivityService)
    }

    override func tearDownWithError() throws {
        viewController = nil
        mockViewModel = nil
        mockNetworkService = nil
        mockConnectivityService = nil
        super.tearDown()
    }

    func testViewDidLoad() {
        viewController.loadViewIfNeeded()

        XCTAssertNotNil(viewController.sportsCollectionView.dataSource, "Data source should be set")
        XCTAssertNotNil(viewController.sportsCollectionView.delegate, "Delegate should be set")
    }

    func testLayoutToggleButtonPressed() {
        viewController.loadViewIfNeeded()
        let initialLayoutType = mockViewModel.layoutType

        let newLayoutType = mockViewModel.layoutType

        XCTAssertNotEqual(initialLayoutType, newLayoutType, "Layout type should toggle")
        let expectedImageName = newLayoutType == .orthogonal ? "square.grid.2x2" : "list.bullet"
        XCTAssertEqual(viewController.layoutToggleButton.image?.pngData(), UIImage(systemName: expectedImageName)?.pngData(), "Button image should be updated")
    }

    func testCollectionViewDataSource() {
        viewController.loadViewIfNeeded()

        let numberOfItems = viewController.collectionView(viewController.sportsCollectionView, numberOfItemsInSection: 0)
        XCTAssertEqual(numberOfItems, 4, "Number of items should match the sportsItems count")
    }

    func testCollectionViewDelegateWithInternet() {
        // Simulate connectivity
        mockConnectivityService.isConnected = true

        // Simulate item selection
        viewController.collectionView(viewController.sportsCollectionView, didSelectItemAt: IndexPath(row: 0, section: 0))

        // Verify navigation or other effects
        // Example: Add your own assertion here if you can verify navigation or any other effects.
    }


    class MockAllSportsViewModel: AllSportsViewModel {
        override var sportsItems: [SportsItemModel] {
            return [
                SportsItemModel(imgName: "football", titleName: "Football"),
                SportsItemModel(imgName: "basket", titleName: "Basketball"),
                SportsItemModel(imgName: "cricket", titleName: "Cricket"),
                SportsItemModel(imgName: "tennisBalls", titleName: "Tennis")
            ]
        }
    }

}

    // Mock Connectivity Service for unit testing
    class MockConnectivityService: ConnectivityChecking {
        var isConnected: Bool = true

        func checkInternetConnection(completion: @escaping (Bool) -> Void) {
            // Simulate immediate completion with the current network status
            completion(isConnected)
        }
    }
