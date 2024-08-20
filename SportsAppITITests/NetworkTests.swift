//
//  NetworkTests.swift
//  SportsAppITITests
//
//  Created by Engy on 8/16/24.
//
import XCTest
@testable import SportsAppITI

final class NetworkServiceTests: XCTestCase {

    let networkManager = NetworkService.shared

    // Test successful data fetching and decoding
    func testNetworkServiceSuccess() {
        let expectation = self.expectation(description: "Test Network Service Success")
        let endpoint = SportsAPI.getUpcomingEvents(leagueId: 123, fromDate: .now, toDate: .upcoming)

        networkManager.fetchData(from: endpoint, model: EventsModel.self) { result, error in
            if let error = error {
                XCTFail("Failed with error: \(error.localizedDescription)")
            } else if let eventsModel = result {
                let events = eventsModel.result
                XCTAssertNotEqual(events.count, 0, "Expected to receive events but got an empty list.")
                expectation.fulfill()
            } else {
                XCTFail("Expected valid data but got nil.")
            }
        }

        waitForExpectations(timeout: 5)
    }

    // Test decoding failure scenario
    func testNetworkServiceDecodeFail() {
        let expectation = self.expectation(description: "Test Network Service Decode Fail")
        let endpoint = SportsAPI.getAllLeagues(sportsName: "football")

        networkManager.fetchData(from: endpoint, model: EventsModel.self) { result, error in
            if let _ = result {
                XCTFail("Expected decoding failure but got valid data.")
            } else if let error = error {
                print("Decoding failed as expected with error: \(error.localizedDescription)")
                expectation.fulfill()
            } else {
                XCTFail("Expected error but got nil.")
            }
        }

        waitForExpectations(timeout: 5)
    }
}
