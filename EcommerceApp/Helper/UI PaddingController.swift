//
//  UI PaddingController.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 16/07/25.
//

import Foundation
import UIKit

func setPaddingForTextFields(_ textFields: [UITextField?], left: CGFloat, right: CGFloat){
    for textField in textFields {
        textField?.setPadding(left: left, right: right)
    }
}

// For Padding

extension UITextField {
    func setPadding(left: CGFloat = 0, right: CGFloat = 0) {
        if left > 0 {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
        
        if right > 0 {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}
