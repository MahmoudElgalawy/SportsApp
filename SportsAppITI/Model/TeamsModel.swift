//
//  TeamModelApi.swift
//  SportsAppITI
//
//  Created by Engy on 8/16/24.
//

import Foundation

// MARK: - TeamModelApi
struct TeamsModel: Codable {
    let success: Int
    let result: [TeamModel]
}

// MARK: - TeamModel
struct TeamModel: Codable {
    let teamKey: Int?
    let teamName: String?
    let teamLogo: String?
    let players: [Player]?

    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players
    }
}


// MARK: - Player
struct Player: Codable {
    let playerType:String?
    let playerKey: Int
    let playerImage: String?
    let playerName, playerNumber: String
    let playerIsCaptain : String?

    enum CodingKeys: String, CodingKey {
        case playerKey = "player_key"
        case playerImage = "player_image"
        case playerName = "player_name"
        case playerNumber = "player_number"
        case playerType = "player_type"
        case playerIsCaptain = "player_is_captain"

    }
}


