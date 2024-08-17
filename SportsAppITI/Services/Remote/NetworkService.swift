//
//  SportsAPI.swift
//  SportsAppITI
//
//  Created by Engy on 8/13/24.
//
import Foundation
import Alamofire
import Network



// Protocol for fetching data
protocol NetworkRequestable {
    func fetchData<T: Codable>(from url: SportsAPI, model: T.Type, completion: @escaping (T?, Error?) -> Void)
}

// MARK: - Network Manager
class NetworkService:NetworkRequestable{

    static let shared = NetworkService()
    private init() {}
    
    func fetchData<T: Codable>(from url : SportsAPI, model: T.Type, completion: @escaping (T?, Error?) -> Void) {
        guard let urlString = url.url(), let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
       
        AF.request(url).responseDecodable(of:model) { response in
            switch response.result {
            case .success(let json):
                do {
                    let decodedData = try JSONDecoder().decode(model, from: response.data!)
                    completion(decodedData, nil)
                } catch let decodeError {
                    completion(nil, decodeError)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

}
