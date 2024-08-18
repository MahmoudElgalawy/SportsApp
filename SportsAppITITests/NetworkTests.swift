//
//  NetworkTests.swift
//  SportsAppITITests
//
//  Created by Engy on 8/16/24.
//
import XCTest
@testable import SportsAppITI

struct MockModel: Codable {
    let success: Int
}

final class NetworkTests: XCTestCase {

    var networkService: NetworkRequestable!

    override func setUpWithError() throws {
        networkService = NetworkService.shared
    }

    override func tearDownWithError() throws {
        networkService = nil
    }

    func testFetchDataSuccess() throws {
        let expectedObject = expectation(description: "API request succeeds")

        networkService.fetchData(from: .getAllLeagues(sportsName: "football"), model: MockModel.self) { result, error in
            XCTAssertNil(error)
            XCTAssertNotNil(result)
            XCTAssertEqual(result?.success, 1)
            expectedObject.fulfill()
        }

        waitForExpectations(timeout: 5)
    }

    func testFetchDataFailure() throws {
        let expectedObject = expectation(description: "API request fails due to network error")

        networkService.fetchData(from: .getAllLeagues(sportsName: "invalid_sport"), model: MockModel.self) { result, error in
            XCTAssertNotNil(error)
            XCTAssertNil(result)
            expectedObject.fulfill()
        }

        waitForExpectations(timeout: 5)
    }

    func testDecodingError() throws {
        let expectedObject = expectation(description: "API request returns decoding error")

        networkService.fetchData(from: .getAllLeagues(sportsName: "football"), model: MockModel.self) { result, error in
            XCTAssertNotNil(error)
            XCTAssertNil(result)
            expectedObject.fulfill()
        }

        waitForExpectations(timeout: 5)
    }

    func testInvalidURL() throws {
        let expectedObject = expectation(description: "API request with invalid URL")

        networkService.fetchData(from: SportsAPI.getAllLeagues(sportsName: ""), model: MockModel.self) { (result: MockModel?, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(result)
            expectedObject.fulfill()
        }

        waitForExpectations(timeout: 5)
    }
}
