//
//  PhoneMaskFormatter.swift
//  examLTEX
//
//  Created by vacwin on 21.06.2025.
//

import Foundation
struct PhoneMaskFormatter {
    static public func split(_ phoneMask: String) -> (String, String, Character)? {
        guard let firstIndex = phoneMask.firstIndex(where: { $0 == " " || $0 == "(" }) else {
            return nil
        }
        let code = String(phoneMask[..<firstIndex])
        let mask = String(phoneMask[firstIndex...])
        if let ch = mask.first(where: \.isLetter) {
            return (code, mask, ch)
        }
        return (code, mask, "Х")
    }
    
    static func format(_ phoneNumber: String, with phoneMask: String, and char: Character) -> String {
        let numbers = phoneNumber.filter { $0.isNumber }
        var formattedResult = ""
        var index = numbers.startIndex
        for ch in phoneMask {
            if ch == char {
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
