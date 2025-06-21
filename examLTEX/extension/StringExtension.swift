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
}
