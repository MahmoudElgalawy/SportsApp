//
//  MockTeamDetails.swift
//  SportsAppITITests
//
//  Created by Mahmoud  on 18/08/2024.
//

//
//import Foundation
//
//
//@testable import SportsAppITI
//
//class MockRemoteSource: NetworkRequestable {
//    var mockData: Data?
//    var mockError: Error?
//    
//    private let fakeJsonData = """
//    {
//        "success": 1,
//        "result": [
//            {
//                "team_key": 103,
//                "team_name": "Istanbul Basaksehir",
//                "team_logo": "https://apiv2.allsportsapi.com/logo/103_istanbul-basaksehir.jpg",
//                "players": [
//                    {
//                        "player_key": 1926895471,
//                        "player_image": "https://apiv2.allsportsapi.com/logo/players/354_o-ahiner.jpg",
//                        "player_name": "Ö. Şahiner",
//                        "player_number": "42",
//                        "player_type": "Midfielders",
//                        "player_age": "32",
//                        "player_match_played": "0",
//                        "player_goals": "0"
//                    },
//                    {
//                        "player_key": 3904538867,
//                        "player_image": "https://apiv2.allsportsapi.com/logo/players/3260_s-gurler.jpg",
//                        "player_name": "S. Gürler",
//                        "player_number": "7",
//                        "player_type": "Midfielders",
//                        "player_age": "32",
//                        "player_match_played": "1",
//                        "player_goals": "0"
//                    }
//                ]
//            }
//        ]
//    }
//    """.data(using: .utf8)
//    
//    init() {
//        self.mockData = fakeJsonData
//    }
//    
//    func fetchData<T: Decodable>(from endpoint: SportsAPI, model: T.Type, completion: @escaping (T?, Error?) -> Void) {
//        if let data = mockData {
//            let decoder = JSONDecoder()
//            do {
//                let result = try decoder.decode(T.self, from: data)
//                completion(result, nil)
//            } catch {
//                completion(nil, error)
//            }
//        } else {
//            completion(nil, mockError)
//        }
//    }
//}
