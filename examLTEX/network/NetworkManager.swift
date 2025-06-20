//
//  NetworkManager.swift
//  examLTEX
//
//  Created by vacwin on 20.06.2025.
//

import Foundation
import Alamofire
class NetworkManager {
    static let shared = NetworkManager()
    private let session: Session
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 //?
        self.session = Session(configuration: configuration)
    }
    
    final func get<T: Decodable>(
        _ url: URLConvertible,
        _ parameters: Parameters? = nil,
        _ headers: HTTPHeaders = [:],
        _ response: T.Type,
        _ completion: @escaping (Result<T, AFError>) -> Void
    ) {
        self.session.request(
            url,
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.default,
            headers: headers
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
    final func post<T: Decodable>(
        _ url: URLConvertible,
        _ parameters: Parameters? = nil,
        _ headers: HTTPHeaders = [:],
        _ response: T.Type,
        _ completion: @escaping (Result<T, AFError>) -> Void
    ) {
        self.session.request(
            url,
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.default,
            headers: headers
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
}
