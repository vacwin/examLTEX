//
//  RequestManager.swift
//  examLTEX
//
//  Created by vacwin on 20.06.2025.
//

import Foundation
class RequestManager {
    static let shared = RequestManager()
    public func getNetwork(_ completion: @escaping(Network?, Error?) -> Void) {
        NetworkManager.shared.get(
            APIInfo.netowrkUrl,
            nil,
            [:],
            Network.self
        ) { result in
            switch result {
            case .success(let network):
                completion(network, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
