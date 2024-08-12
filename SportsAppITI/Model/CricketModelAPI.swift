//
//  CricketModelAPI.swift
//  SportsAppITI
//
//  Created by Engy on 8/12/24.
//

import Foundation
struct CricketModelAPI: Codable {
    let success: Int
    let result: [CricketModel]
}

// MARK: - Result
struct CricketModel: Codable {
    let leagueKey: Int
    let leagueName, leagueYear: String

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case leagueYear = "league_year"
    }
}
