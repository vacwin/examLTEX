//
//  PhoneMaskFormatter.swift
//  examLTEX
//
//  Created by vacwin on 21.06.2025.
//

import Foundation
class PhoneMaskFormatter {
    static public func format(_ phoneMask: String) -> (String, String)? {
        guard let firstBracketIndex = phoneMask.firstIndex(of: " ") else {
            return nil
        }
        let code = String(phoneMask[..<firstBracketIndex]).trimmingCharacters(in: .whitespaces)
        let mask = String(phoneMask[firstBracketIndex...])
        return (code, mask)
    }
}
