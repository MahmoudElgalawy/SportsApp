//
//  mymockDetailsTest.swift
//  SportsAppITITests
//
//  Created by Mahmoud  on 19/08/2024.
//

import XCTest

final class mymockDetailsTest: XCTestCase {
    var mockRemoteSource: MockRemoteSource!
    override func setUpWithError() throws {
        mockRemoteSource = MockRemoteSource()
        
    }

    override func tearDownWithError() throws {
        mockRemoteSource = nil
    }
    func testFetchDataSuccess() {
        let expectation = self.expectation(description: "Fetch data success")
        
        
//        mockRemoteSource.fetchData(from: .getTeamDetails(teamId: 103), model:TeamModelApi.self) { (result: TeamModelApi?, error: Error?) in
//            if let error = error{
//                XCTFail()
//            }else{
//                XCTAssertNil(error, "Expected no error")
//                XCTAssertNotNil(result, "Expected result to be non-nil")
//                XCTAssertEqual(result?.success, 1, "Expected success to be 1")
//                XCTAssertEqual(result?.result.count, 1, "Expected 1 team")
//                XCTAssertEqual(result?.result.first?.players?.count, 2, "Expected 2 players")
//                XCTAssertEqual(result?.result.first?.players?.first?.playerName, "Ö. Şahiner", "Expected player name to be Ö. Şahiner")
//                XCTAssertEqual(result?.result.first?.players?.last?.playerName, "S. Gürler", "Expected player name to be S. Gürler")
//                expectation.fulfill()
//            }
//        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }

}
