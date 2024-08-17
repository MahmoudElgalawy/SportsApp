//
//  ConnectivityService.swift
//  SportsAppITI
//
//  Created by Engy on 8/16/24.
//

import Foundation
import Network
protocol ConnectivityChecking {
    func checkInternetConnection(completion: @escaping (Bool) -> Void)
}

class ConnectivityService: ConnectivityChecking {
    static let shared = ConnectivityService()
    private init() {}


     
    func checkInternetConnection(completion: @escaping (Bool) -> Void) {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                completion(path.status == .satisfied)
                monitor.cancel()
            }
        }
        monitor.start(queue: .main)
    }
}
