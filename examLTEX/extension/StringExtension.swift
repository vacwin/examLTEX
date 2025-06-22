//
//  StringExtension.swift
//  examLTEX
//
//  Created by vacwin on 21.06.2025.
//

import Foundation
import UIKit
extension String {
    var removePhoneChars: String {
        let charsToRemove = CharacterSet(charactersIn: "()+- ")
        return self.components(separatedBy: charsToRemove).joined()
    }
    
    func toDate() -> String? {
        guard let date = self.toISODate() else { return nil }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "dd MMMM, HH:mm"
        return formatter.string(from: date)
    }
    
    func toISODate() -> Date? {
        return ISO8601DateFormatter().date(from: self)
    }
}
