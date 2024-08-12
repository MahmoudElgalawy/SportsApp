//
//  Api.swift
//  SportsAppITI
//
//  Created by Engy on 8/11/24.
//

import Foundation


private let apiKey = "f388c6b66cb3de08a66bad91a62079ed4b733ed8a6719ad9010b2391ad9a90e2"

let football = ""
let basketball = "https://apiv2.allsportsapi.com/basketball/"
let cricket = "https://apiv2.allsportsapi.com/cricket/"

let getAllLeague = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=[YourKey]"

let getUpcomingEvents =
"https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=[leagueId]&from=[CurrentDate]&to=[CurrentDate + OneYear]&APIkey=[YourKey]"
//Example:
//https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=205&from=2023-01-18&to=2024-01-18&APIkey=f425b6bc70085b127f48d285251e2d85c423aa2f33cee948d703b11432bcebbb

let getLatestResults =
"https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=[leagueId]&from=[CurrentDate - OneYear]&to=[CurrentDate]&APIkey=[YourKey]"
//Example:
//https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=205&from=from=2022-01-18&to=2023-01-18&APIkey=[YourKey]

let getAllTeamsOfaLeague = ""

//You will get some data from the response of the upcoming event and the latest results
//-> Concatenate all the following attributes of a team in a teams array:
//- home_team_key or away_team_key
//- event_home_team or event_away_team
//-home_team_logo or away_team_logo



let getTeamDetails = "https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=[team_key]&APIkey=[YourKey]"


