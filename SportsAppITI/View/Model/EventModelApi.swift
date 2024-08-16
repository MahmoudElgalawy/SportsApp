//
//  EventModel.swift
//  SportsAppITI
//
//  Created by Engy on 8/12/24.
//
import Foundation
//MARK: - Welcome
struct EventModelAPIResponse: Codable {
    let success: Int
    let result: [EventModel]
}

// MARK: - Result
struct EventModel: Codable {
    let homeTeamLogo: String?
    let eventHomeTeam: String?
    let awayTeamLogo: String?
    let eventAwayTeam: String?
    let leagueLogo: String?
    let eventFinalResult: String?
    let eventDate: String?
    let eventTime: String?
    let homeTeamKey: Int
    let awayTeamKey: Int
    //

    enum CodingKeys: String, CodingKey {
        case homeTeamLogo = "home_team_logo"
        case eventHomeTeam = "event_home_team"
        case awayTeamLogo = "away_team_logo"
        case eventAwayTeam = "event_away_team"
        case leagueLogo = "league_logo"
        case eventFinalResult = "event_final_result"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case homeTeamKey = "home_team_key"
        case awayTeamKey = "away_team_key"
    }
}
