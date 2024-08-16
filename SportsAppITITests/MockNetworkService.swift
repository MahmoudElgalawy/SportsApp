//
//  MockNetworkService.swift
//  SportsAppITITests
//
//  Created by Engy on 8/16/24.
//

import XCTest
@testable import SportsAppITI

//class MockNetworkService:fech{
//    func fetchData<T: Codable>(from url: URL, model: T.Type, completion: @escaping (T?, Error?) -> Void) {
//            if let error = mockError {
//                completion(nil, error)
//            } else if let data = mockData {
//                do {
//                    let decodedData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                    // Assuming that model has an initializer that takes a dictionary
//                    let modelInstance = T.self as? SomeCodableModel.Type
//                    let result = modelInstance?.init(dictionary: decodedData ?? [:]) as? T
//                    completion(result, nil)
//                } catch {
//                    completion(nil, error)
//                }
//            }
//        }
//
//
//
//}
