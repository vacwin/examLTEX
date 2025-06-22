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
    
    public func authenticateUser(with phone: String, and password: String, _ completion: @escaping(AuthStatus?, Error?) -> Void) {
        let parameters = [
            "phone": phone,
            "password": password
        ]
        NetworkManager.shared.post(
            APIInfo.authUrl,
            parameters,
            [
                "Conetnt-Type":"application/x-www-form-urlencoded"
            ],
            AuthStatus.self
        ) { result in
            switch result {
            case .success(let authStatus):
                completion(authStatus, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    public func getPosts(_ completion: @escaping([Post]?, Error?) -> Void) {
        NetworkManager.shared.get(
            APIInfo.postsUrl,
            nil,
            [:],
            [Post].self
        ) { result in
            switch result {
            case .success(let posts):
                completion(posts, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
