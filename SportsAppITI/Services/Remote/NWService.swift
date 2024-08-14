//
//  SportsAPI.swift
//  SportsAppITI
//
//  Created by Engy on 8/13/24.
//
import Foundation
import Alamofire


// MARK: - Network Manager
class NWService {
    static let shared = NWService()
    private init() {}

    func getAllData<T: Codable>(sportName: SportsAPI, model: T.Type, completion: @escaping (T?, Error?) -> Void) {
        guard let urlString = sportName.url(), let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        NSLog("")

        NSLog("Requesting data from URL: %@", url.absoluteString)

        AF.request(url).responseDecodable(of:model) { response in
            switch response.result {
            case .success(let json):
                print("JSON Response: \(json)")
                do {
                    let decodedData = try JSONDecoder().decode(model, from: response.data!)
                    print("Data received: \(decodedData)")
                    completion(decodedData, nil)
                } catch let decodeError {
                    print("Decoding error: \(decodeError)")
                    completion(nil, decodeError)
                }
            case .failure(let error):
                print("Error occurred: \(error.localizedDescription)")
                completion(nil, error)
            }
        }
    }

}
