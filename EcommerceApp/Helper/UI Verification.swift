//
//  UI Verification.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 25/07/25.
//

import Foundation
import UIKit

func isValidPassword(_ password: String) -> Bool {
    
    let passwordRegex = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$"#
    let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
    return passwordPredicate.evaluate(with: password)
    
}

func isValidEmail(_ email: String) -> Bool {
    
    let emailRegEx = #"^[A-Z0-9a-z]+@gmail.com$"#
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return emailPredicate.evaluate(with: email)
}

