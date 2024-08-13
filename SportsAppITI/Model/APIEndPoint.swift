//
//  File.swift
//  SportsAppITI
//
//  Created by Mahmoud  on 13/08/2024.
//

import Foundation
/*
struct APIEndpoints {
    private static let apiKey = "f388c6b66cb3de08a66bad91a62079ed4b733ed8a6719ad9010b2391ad9a90e2"
    
    private static let baseURL = "https://apiv2.allsportsapi.com/"
    
    static let basketball = "\(baseURL)basketball/"
    static let cricket = "\(baseURL)cricket/"
    
    static let getAllLeagues = "\(baseURL)football/?met=Leagues&APIkey=\(apiKey)"
    static let getUpcomingEvents = "\(baseURL)football?met=Fixtures&leagueId=[leagueId]&from=[CurrentDate]&to=[CurrentDate + OneYear]&APIkey=\(apiKey)"
    static let getLatestResults = "\(baseURL)football?met=Fixtures&leagueId=[leagueId]&from=[CurrentDate - OneYear]&to=[CurrentDate]&APIkey=\(apiKey)"
    static let getTeamDetails = "\(baseURL)football/?met=Teams&teamId=[team_key]&APIkey=\(apiKey)"
    
    static func getUpcomingEvents(for leagueId: String, fromDate: String, toDate: String) -> String {
        return "\(baseURL)football?met=Fixtures&leagueId=\(leagueId)&from=\(fromDate)&to=\(toDate)&APIkey=\(apiKey)"
    }
    
    static func getLatestResults(for leagueId: String, fromDate: String, toDate: String) -> String {
        return "\(baseURL)football?met=Fixtures&leagueId=\(leagueId)&from=\(fromDate)&to=\(toDate)&APIkey=\(apiKey)"
    }
    
    static func getTeamDetails(for teamId: String) -> String {
        return "\(baseURL)football/?met=Teams&teamId=\(teamId)&APIkey=\(apiKey)"
    }
    }
*/


enum APIEndPoint {
    private static let apiKey = "f388c6b66cb3de08a66bad91a62079ed4b733ed8a6719ad9010b2391ad9a90e2"
    
    private static let baseURL = "https://apiv2.allsportsapi.com/"
    
    case basketball
    case cricket
    case AllLeagues
    case UpcomingEvents
    case LatestResults
    case TeamDetails
    case getUpcomingEvents(leagueId: String, fromDate: String, toDate: String)
    case getLatestResults(leagueId: String, fromDate: String, toDate: String)
    case getTeamDetails(teamId: String)

}


extension APIEndPoint{
    func url()->String {
        switch self {
        case .basketball:
            return "\(APIEndPoint.baseURL)basketball/"
        case .cricket:
            return "\(APIEndPoint.baseURL)cricket/"
        case .AllLeagues :
            return "\(APIEndPoint.baseURL)football/?met=Leagues&APIkey=\(APIEndPoint.apiKey)"
        case .UpcomingEvents :
            return "\(APIEndPoint.baseURL)football/?met=Leagues&APIkey=\(APIEndPoint.apiKey)"
        case .LatestResults :
            return "\(APIEndPoint.baseURL)football?met=Fixtures&leagueId=[leagueId]&from=[CurrentDate - OneYear]&to=[CurrentDate]&APIkey=\(APIEndPoint.apiKey)"
        case .TeamDetails :
            return "\(APIEndPoint.baseURL)football/?met=Teams&teamId=[team_key]&APIkey=\(APIEndPoint.apiKey)"
        case .getUpcomingEvents(let leagueId,let fromDate, let toDate):
             return "\(APIEndPoint.baseURL)football/?met=Fixtures&leagueId=\(leagueId)&from=\(fromDate)&to=\(toDate)&APIkey=\(APIEndPoint.apiKey)"
        case .getLatestResults(let leagueId,let fromDate,let toDate):
              return "\(APIEndPoint.baseURL)football/?met=Fixtures&leagueId=\(leagueId)&from=\(fromDate)&to=\(toDate)&APIkey=\(APIEndPoint.apiKey)"
        case .getTeamDetails(let teamId):
            return "\(APIEndPoint.baseURL)football/?met=Teams&teamId=\(teamId)&APIkey=\(APIEndPoint.apiKey)"
        default:
            return "go to hell"
        }
    }
}

