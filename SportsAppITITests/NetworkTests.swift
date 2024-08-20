////
////  NetworkTests.swift
////  SportsAppITITests
////
////  Created by Engy on 8/16/24.
////
//import XCTest
//import Alamofire
//@testable import SportsAppITI
//
//class MockNetworkService: NetworkService {
//    var mockData: Data?
//    var mockError: Error?
//
//    override func fetchData<T: Codable>(from url: SportsAPI, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
//        if let mockError = mockError {
//            completion(.failure(mockError))
//            return
//        }
//
//        guard let mockData = mockData else {
//            completion(.failure(NetworkError.invalidURL))
//            return
//        }
//
//        let decoder = JSONDecoder()
//        let result: Result<T, Error> = decoder.decodeResult(T.self, from: mockData)
//        completion(result)
//    }
//}
//
//class NetworkServiceTests: XCTestCase {
//
//    var networkService: MockNetworkService!
//
//    override func setUp() {
//        super.setUp()
//        networkService = MockNetworkService.shared as! MockNetworkService
//    }
//
//    override func tearDown() {
//        networkService = nil
//        super.tearDown()
//    }
//
//    func testFetchDataSuccess() {
//        // Given
//        let mockModel = MockModel(id: 1, name: "Test Team")
//        let mockData = try! JSONEncoder().encode(mockModel)
//        networkService.mockData = mockData
//        let mockAPI = MockSportsAPI(urlString: "https://mockapi.com/success")
//
//        // When
//        networkService.fetchData(from: mockAPI, model: MockModel.self) { result in
//            switch result {
//            case .success(let model):
//                // Then
//                XCTAssertEqual(model, mockModel)
//            case .failure(let error):
//                XCTFail("Expected success but got failure with error: \(error)")
//            }
//        }
//    }
//
//    func testFetchDataFailure() {
//        // Given
//        let mockError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
//        networkService.mockError = mockError
//        let mockAPI = SportsAPI(urlString: "https://mockapi.com/failure")
//
//        // When
//        networkService.fetchData(from: mockAPI, model: MockModel.self) { result in
//            switch result {
//            case .success:
//                XCTFail("Expected failure but got success")
//            case .failure(let error):
//                // Then
//                XCTAssertEqual(error.localizedDescription, "Mock error")
//            }
//        }
//    }
//}
