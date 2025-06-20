//
//  PaddingTextField.swift
//  examLTEX
//
//  Created by vacwin on 20.06.2025.
//

import Foundation
import UIKit
class PaddingTextField: UITextField {
    var padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var tempInset = self.padding
        if let rightView {
            tempInset.right += rightView.frame.width + 8
        }
        return bounds.inset(by: tempInset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var tempInset = self.padding
        if let rightView {
            tempInset.right += rightView.frame.width + 8
        }
        return bounds.inset(by: tempInset)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        var tempInset = self.padding
        if let rightView {
            tempInset.right += rightView.frame.width + 8
        }
        return bounds.inset(by: tempInset)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let size = super.rightViewRect(forBounds: bounds)
        return CGRect(
            x: bounds.width - size.width - self.padding.right,
            y: size.origin.y,
            width: size.width,
            height: size.height
        )
    }
}
