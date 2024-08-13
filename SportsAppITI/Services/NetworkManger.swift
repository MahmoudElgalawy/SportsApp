import Foundation
import Alamofire


// MARK: - Network Manager
class NWService {

    static let shared = NWService()
    private let apiKey = "f388c6b66cb3de08a66bad91a62079ed4b733ed8a6719ad9010b2391ad9a90e2"
    private init() {}

    func getAllData<T:Codable>(sportName: APIEndPoint, model:T.Type,completion: @escaping (T?, Error?) -> Void){
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
//class NWService {
//
//    static let shared = NWService()
//    private let apiKey = "f388c6b66cb3de08a66bad91a62079ed4b733ed8a6719ad9010b2391ad9a90e2"
//    private init() {}
//
//    func getAllData<T:Codable>(sportName: String, model:T.Type,completion: @escaping (T?, Error?) -> Void){
//        let url = "https://apiv2.allsportsapi.com/\(sportName)/?met=Leagues&APIkey=\(apiKey)"
//        AF.request(url).responseDecodable(of: model) { response in
//            switch response.result {
//            case .success(let data):
//                completion(data, nil)
//            case .failure(let error):
//                completion(nil, error)
//            }
//        }
//    }
//}
