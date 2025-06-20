//
//  Network.swift
//  examLTEX
//
//  Created by vacwin on 20.06.2025.
//

import Foundation
struct Network: Decodable {
    var phoneMask: String?
    
    private enum CodingKeys: String, CodingKey {
        case phoneMask = "phoneMask"
    }
}
