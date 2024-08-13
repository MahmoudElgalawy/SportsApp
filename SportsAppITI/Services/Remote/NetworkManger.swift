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
    private let apiKey = "f388c6b66cb3de08a66bad91a62079ed4b733ed8a6719ad9010b2391ad9a90e2"
    private init() {}


    func getAllData<T:Codable>(sportName: SportsAPI, model:T.Type,completion: @escaping (T?, Error?) -> Void){
        let url = sportName.url() 
         

        AF.request(url).responseDecodable(of: model) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
