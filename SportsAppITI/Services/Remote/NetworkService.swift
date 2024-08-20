//
//  SportsAPI.swift
//  SportsAppITI
//
//  Created by Engy on 8/13/24.
//
import Foundation
import Alamofire
import Network



import Foundation
import Alamofire

// Protocol for fetching data
protocol NetworkRequestable {
    func fetchData<T: Codable>(from url: SportsAPI, model: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

// MARK: - Network Manager
class NetworkService: NetworkRequestable {

    static let shared = NetworkService()
    private init() {}

    func fetchData<T: Codable>(from url: SportsAPI, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let urlString = url.url() else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        AF.request(urlString).responseDecodable(of: model) { response in
            switch response.result {
            case .success(let decodedData):
                completion(.success(decodedData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// Custom Network Errors
enum NetworkError: Error {
    case invalidURL
}

// Extension to handle JSON decoding errors
extension JSONDecoder {
    func decodeResult<T: Codable>(_ type: T.Type, from data: Data?) -> Result<T, Error> {
        guard let data = data else {
            return .failure(NetworkError.invalidURL) 
        }

        do {
            let decodedData = try self.decode(T.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(error)
        }
    }
}


