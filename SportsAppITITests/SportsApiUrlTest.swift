//
//  SportsApiUrlTest.swift
//  SportsAppITITests
//
//  Created by Engy on 8/18/24.
//

import XCTest
@testable import SportsAppITI

final class SportsApiUrlTest: XCTestCase {

    func test_getAllLeaguesURL() {
        let sportsName = "football"
        let api = SportsAPI.getAllLeagues(sportsName: sportsName)
        let url = api.url()
        let expectedURLString = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=f388c6b66cb3de08a66bad91a62079ed4b733ed8a6719ad9010b2391ad9a90e2"
        XCTAssertEqual(url?.absoluteString, expectedURLString, "URL for getAllLeagues is incorrect")
    }
    func test_getUpcomingEventsURL() {
        let leagueId = 123
        let fromDate = DataRange.now
        let toDate = DataRange.upcoming
        let api = SportsAPI.getUpcomingEvents(leagueId: leagueId, fromDate: fromDate, toDate: toDate)
        let url = api.url()
        let expectedURLString = "https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=123&from=\(fromDate.year)&to=\(toDate.year)&APIkey=f388c6b66cb3de08a66bad91a62079ed4b733ed8a6719ad9010b2391ad9a90e2"
        XCTAssertEqual(url?.absoluteString, expectedURLString, "URL for getUpcomingEvents is incorrect")
    }

    func test_getLatestResultsURL() {
        let leagueId = 456
        let fromDate = DataRange.now
        let toDate = DataRange.upcoming
        let api = SportsAPI.getLatestResults(leagueId: leagueId, fromDate: fromDate, toDate: toDate)

        let url = api.url()
        let expectedURLString = "https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=456&from=\(fromDate.year)&to=\(toDate.year)&APIkey=f388c6b66cb3de08a66bad91a62079ed4b733ed8a6719ad9010b2391ad9a90e2"
        XCTAssertEqual(url?.absoluteString, expectedURLString, "URL for getLatestResults is incorrect")
    }

    func test_getAllTeamsInLeagueURL() {
        let leagueId = "789"
        let api = SportsAPI.getAllTeamsInLeague(leagueId: leagueId)
        let url = api.url()
        let expectedURLString = "https://apiv2.allsportsapi.com/football/?met=Teams&leagueId=789&APIkey=f388c6b66cb3de08a66bad91a62079ed4b733ed8a6719ad9010b2391ad9a90e2"
        XCTAssertEqual(url?.absoluteString, expectedURLString, "URL for getAllTeamsInLeague is incorrect")
    }
    func test_getTeamDetailsURL() {
        let teamId = 101
        let api = SportsAPI.getTeamDetails(teamId: teamId)
        let url = api.url()
        let expectedURLString = "https://apiv2.allsportsapi.com/football/?met=Teams&teamId=101&APIkey=f388c6b66cb3de08a66bad91a62079ed4b733ed8a6719ad9010b2391ad9a90e2"
        XCTAssertEqual(url?.absoluteString, expectedURLString, "URL for getTeamDetails is incorrect")
    }
}
