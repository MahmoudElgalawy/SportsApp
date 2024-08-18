//
//  CheckInternetTests.swift
//  SportsAppITITests
//
//  Created by Engy on 8/18/24.
//

import XCTest
@testable import SportsAppITI

final class CheckInternetTests: XCTestCase {
    var connectivityService : ConnectivityChecking?

    override func setUpWithError() throws {
        connectivityService = ConnectivityService.shared

    }

    override func tearDownWithError() throws {
        connectivityService = nil

    }

    func  testConnectivityService () throws {
        let exp = expectation(description: "")
        connectivityService?.checkInternetConnection(completion: { _ in
            exp.fulfill()
        })
        waitForExpectations(timeout: 2)
    }


}
