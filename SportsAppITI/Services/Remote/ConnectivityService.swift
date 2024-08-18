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

    private var monitor: NWPathMonitor

    init(monitor: NWPathMonitor = NWPathMonitor()) {
        self.monitor = monitor
    }

    func checkInternetConnection(completion: @escaping (Bool) -> Void) {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                completion(path.status == .satisfied)
                self.monitor.cancel()
            }
        }
        monitor.start(queue: .main)
    }
}
