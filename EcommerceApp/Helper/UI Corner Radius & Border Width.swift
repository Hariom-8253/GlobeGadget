//
//  UI Corner Radius & Border Width.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 29/07/25.
//

import Foundation
import UIKit

//func styleTextfields(_ textFields: [UITextField], cornerRadius : CGFloat, borderWidth: CGFloat){
//    for textField in textFields {
//        textField.layer.cornerRadius = cornerRadius
//        textField.layer.borderWidth = borderWidth
//        textField.layer.borderColor = UIColor.colorPrimary.cgColor
//    }
//}

func styleViews(_ views: [UIView], cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: CGColor){
    
    for view in views {
        view.layer.cornerRadius = cornerRadius
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor
    }
    
}
