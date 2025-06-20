//
//  KeychainService.swift
//  examLTEX
//
//  Created by vacwin on 20.06.2025.
//

import Foundation
import Security
class KeychainService {
    static let shared = KeychainService()
    private init() {}
    
    final func save(_ value: String, _ key: String) {
        guard let data = value.data(using: .utf8) else { return }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    final func get(_ key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: true
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard
            status == errSecSuccess,
            let data = item as? Data,
            let value = String(data: data, encoding: .utf8)
        else { return nil }
        return value
    }
}
