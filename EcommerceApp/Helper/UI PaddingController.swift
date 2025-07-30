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
