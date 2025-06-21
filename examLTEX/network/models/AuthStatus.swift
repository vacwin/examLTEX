//
//  AuthStatus.swift
//  examLTEX
//
//  Created by vacwin on 21.06.2025.
//

import Foundation
struct AuthStatus: Decodable {
    var success: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case success = "success"
    }
}
