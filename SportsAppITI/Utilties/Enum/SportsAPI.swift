//
//  SportsAPI.swift
//  SportsAppITI
//
//  Created by Engy on 8/13/24.
//

import Foundation

enum SportsAPIError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case networkError(Error)
}

enum SportsAPI {

    case getAllLeagues(sportsName: String)
    case getUpcomingEvents(leagueId: Int, fromDate: DataRange, toDate: DataRange)
    case getLatestResults(leagueId: Int, fromDate: DataRange, toDate: DataRange)
    case getAllTeamsInLeague(leagueId: String)
    case getTeamDetails(teamId: Int)

    private var apiKey: String {
        return "f388c6b66cb3de08a66bad91a62079ed4b733ed8a6719ad9010b2391ad9a90e2"
    }

    private var baseURL: String {
        return "https://apiv2.allsportsapi.com"
    }

    func url() -> URL? {
        let urlString: String

        switch self {
        case .getAllLeagues(let sportsName):
             urlString = "\(baseURL)/\(sportsName)/?met=Leagues&APIkey=\(apiKey)"

        case .getUpcomingEvents(let leagueId, let fromDate, let toDate):
            let leagueIdString = String(leagueId)
             urlString = "\(baseURL)/football?met=Fixtures&leagueId=\(leagueIdString)&from=\(fromDate.year)&to=\(toDate.year)&APIkey=\(apiKey)"

        case .getLatestResults(let leagueId, let fromDate, let toDate):
            let leagueIdString = String(leagueId)
             urlString = "\(baseURL)/football?met=Fixtures&leagueId=\(leagueIdString)&from=\(fromDate.year)&to=\(toDate.year)&APIkey=\(apiKey)"

        case .getAllTeamsInLeague(let leagueId):
             urlString = "\(baseURL)/football/?met=Teams&leagueId=\(leagueId)&APIkey=\(apiKey)"

        case .getTeamDetails(let teamId):
             urlString = "\(baseURL)/football/?met=Teams&teamId=\(teamId)&APIkey=\(apiKey)"
        }

        return URL(string: urlString)
    }
}
