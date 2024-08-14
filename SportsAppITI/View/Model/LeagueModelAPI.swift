//
//  Model.swift
//  SportsAppITI
//
//  Created by Engy on 8/12/24.
//

import Foundation
struct LeagueModelAPI: Codable {
    let success: Int
    let result: [LeagueModel]
}

struct LeagueModel: Codable {
    let leagueKey: Int
    let leagueName: String
    let countryKey: Int?
    let countryName: String?
    let leagueLogo : String?
    let countryLogo: String?
    let leagueYear:String?
    //delte it just for test
    let eventKey:Int?

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryKey = "country_key"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
        case leagueYear = "league_year"
        //delte it just for test

        case eventKey = "event_key"

    }
}
