//
//  PhoneMaskFormatter.swift
//  examLTEX
//
//  Created by vacwin on 21.06.2025.
//

import Foundation
struct PhoneMaskFormatter {
    static public func split(_ phoneMask: String) -> (String, String)? {
        guard let firstBracketIndex = phoneMask.firstIndex(of: " ") else {
            return nil
        }
        let code = String(phoneMask[..<firstBracketIndex]).trimmingCharacters(in: .whitespaces)
        let mask = String(phoneMask[firstBracketIndex...])
        return (code, mask)
    }
    
    static func format(_ phoneNumber: String, with phoneMask: String) -> String {
        let numbers = phoneNumber.filter { $0.isNumber }
        var formattedResult = ""
        var index = numbers.startIndex
        for ch in phoneMask {
            if ch == "X" {
                if index < numbers.endIndex {
                    formattedResult.append(numbers[index])
                    index = numbers.index(after: index)
                } else {
                    break
                }
            } else {
                formattedResult.append(ch)
            }
        }
        return formattedResult
    }
}
