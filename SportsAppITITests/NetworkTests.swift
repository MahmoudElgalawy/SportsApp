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
            XCTAssertNil(error, "Expected no error but got \(String(describing: error))")
            XCTAssertNotNil(result, "Expected result to be non-nil")
            XCTAssertEqual(result?.success, 1, "Expected success value to be 1")
            expectedObject.fulfill()
        }

        waitForExpectations(timeout: 5)
    }

    func testFetchDataFailure() throws {
        let expectedObject = expectation(description: "API request fails due to network error")

        networkService.fetchData(from: .getAllLeagues(sportsName: "invalid_sport"), model: MockModel.self) { result, error in
            XCTAssertNotNil(error, "Expected an error but got none")
            XCTAssertNil(result, "Expected result to be nil")
            expectedObject.fulfill()
        }

        waitForExpectations(timeout: 5)
    }

//    func testDecodingError() throws {
//        let expectedObject = expectation(description: "API request returns decoding error")
//
//        networkService.fetchData(from: .getAllLeagues(sportsName: "football"), model: MockModel.self) { result, error in
//            XCTAssertNil(result, "Expected result to be nil")
//            expectedObject.fulfill()
//        }
//        waitForExpectations(timeout: 5)
//    }

    func testInvalidURL() throws {
        let expectedObject = expectation(description: "API request with invalid URL")

        networkService.fetchData(from: .getAllLeagues(sportsName: ""), model: MockModel.self) { result, error in
            XCTAssertNotNil(error, "Expected an error for invalid URL but got none")
            XCTAssertNil(result, "Expected result to be nil")
            expectedObject.fulfill()
        }

        waitForExpectations(timeout: 5)
    }

    func testPerformanceExample() throws {
        measure {
            let expectedObject = expectation(description: "Performance test for fetchData")

            networkService.fetchData(from: .getAllLeagues(sportsName: "football"), model: MockModel.self) { result, error in
                XCTAssertNil(error)
                XCTAssertNotNil(result)
                XCTAssertEqual(result?.success, 1)
                expectedObject.fulfill()
            }

            waitForExpectations(timeout: 5)
        }
    }
}
