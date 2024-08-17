//
//  TeamModelApi.swift
//  SportsAppITI
//
//  Created by Engy on 8/16/24.
//

import Foundation

// MARK: - TeamModelApi
struct TeamModelApi: Codable {
    let success: Int
    let result: [TeamModel]
}

// MARK: - Result
struct TeamModel: Codable {
    let teamKey: Int?
    let teamName: String?
    let teamLogo: String?
    let players: [Player]?
    let coaches: [Coach]?

    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players, coaches
    }
}

// MARK: - Coach
struct Coach: Codable {
    let coachName: String
    let coachCountry:String?
    let coachAge: Int?

    enum CodingKeys: String, CodingKey {
        case coachName = "coach_name"
        case coachCountry = "coach_country"
        case coachAge = "coach_age"
    }
}

// MARK: - Player
struct Player: Codable {
    let playerType:String?
    let playerKey: Int
    let playerImage: String?
    let playerName, playerNumber: String
    let playerCountry: String?
    let playerAge, playerMatchPlayed, playerGoals, playerYellowCards: String
    let playerRedCards: String
    let playerSubstituteOut, playerSubstitutesOnBench, playerAssists: String
    let playerBirthdate: String?
    let playerIsCaptain, playerShotsTotal, playerGoalsConceded, playerFoulsCommitted: String
    let playerTackles, playerBlocks, playerCrossesTotal, playerInterceptions: String
    let playerClearances, playerDispossesed, playerSaves, playerInsideBoxSaves: String
    let playerDuelsTotal, playerDuelsWon, playerDribbleAttempts, playerDribbleSucc: String
    let playerPenComm, playerPenWon, playerPenScored, playerPenMissed: String
    let playerPasses, playerPassesAccuracy, playerKeyPasses, playerWoordworks: String
    let playerRating: String

    enum CodingKeys: String, CodingKey {
        case playerKey = "player_key"
        case playerImage = "player_image"
        case playerName = "player_name"
        case playerNumber = "player_number"
        case playerCountry = "player_country"
        case playerType = "player_type"
        case playerAge = "player_age"
        case playerMatchPlayed = "player_match_played"
        case playerGoals = "player_goals"
        case playerYellowCards = "player_yellow_cards"
        case playerRedCards = "player_red_cards"
        case playerSubstituteOut = "player_substitute_out"
        case playerSubstitutesOnBench = "player_substitutes_on_bench"
        case playerAssists = "player_assists"
        case playerBirthdate = "player_birthdate"
        case playerIsCaptain = "player_is_captain"
        case playerShotsTotal = "player_shots_total"
        case playerGoalsConceded = "player_goals_conceded"
        case playerFoulsCommitted = "player_fouls_committed"
        case playerTackles = "player_tackles"
        case playerBlocks = "player_blocks"
        case playerCrossesTotal = "player_crosses_total"
        case playerInterceptions = "player_interceptions"
        case playerClearances = "player_clearances"
        case playerDispossesed = "player_dispossesed"
        case playerSaves = "player_saves"
        case playerInsideBoxSaves = "player_inside_box_saves"
        case playerDuelsTotal = "player_duels_total"
        case playerDuelsWon = "player_duels_won"
        case playerDribbleAttempts = "player_dribble_attempts"
        case playerDribbleSucc = "player_dribble_succ"
        case playerPenComm = "player_pen_comm"
        case playerPenWon = "player_pen_won"
        case playerPenScored = "player_pen_scored"
        case playerPenMissed = "player_pen_missed"
        case playerPasses = "player_passes"
        case playerPassesAccuracy = "player_passes_accuracy"
        case playerKeyPasses = "player_key_passes"
        case playerWoordworks = "player_woordworks"
        case playerRating = "player_rating"
    }
}


