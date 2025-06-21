//
//  UIButtonExtension.swift
//  examLTEX
//
//  Created by vacwin on 21.06.2025.
//

import Foundation
import UIKit
extension UIButton {
    final func tapAllowed() {
        self.isEnabled = true
        self.backgroundColor =  #colorLiteral(red: 0.0897930488, green: 0.4379105568, blue: 0.9215120673, alpha: 1)
        self.isUserInteractionEnabled = true
    }
    
    final func tapDisabled() {
        self.isEnabled = false
        self.backgroundColor = #colorLiteral(red: 0.7248532176, green: 0.8306887746, blue: 0.9780543447, alpha: 1)
        self.isUserInteractionEnabled = false
    }
}
