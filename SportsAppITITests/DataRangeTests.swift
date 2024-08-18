//
//  DataRangeTests.swift
//  SportsAppITITests
//
//  Created by Engy on 8/18/24.
//

import XCTest
@testable import SportsAppITI

final class DataRangeTests: XCTestCase {

        func test_year_forUpcoming() {
            let dataRange = DataRange.upcoming
            let year = dataRange.year
            let currentYear = Calendar.current.component(.year, from: Date())
            let expectedYear = "\(currentYear + 1)-\(Calendar.current.component(.month, from: Date()))-\(Calendar.current.component(.day, from: Date()))"
            XCTAssertEqual(year, expectedYear, "Year for upcoming range is incorrect")
        }
        func test_year_forPassed() {
            let dataRange = DataRange.passed
            let year = dataRange.year
            let currentYear = Calendar.current.component(.year, from: Date())
            let expectedYear = "\(currentYear - 1)-\(Calendar.current.component(.month, from: Date()))-\(Calendar.current.component(.day, from: Date()))"
            XCTAssertEqual(year, expectedYear, "Year for passed range is incorrect")
        }
        func test_year_forNow() {
            let dataRange = DataRange.now
            let year = dataRange.year
            let currentYear = Calendar.current.component(.year, from: Date())
            let expectedYear = "\(currentYear)-\(Calendar.current.component(.month, from: Date()))-\(Calendar.current.component(.day, from: Date()))"
            XCTAssertEqual(year, expectedYear, "Year for now range is incorrect")
        }
    }
