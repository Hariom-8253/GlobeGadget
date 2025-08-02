//
//  UI Corner Radius & Border Width.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 29/07/25.
//

import Foundation
import UIKit

func styleViews(_ views: [UIView], cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: CGColor){
    
    for view in views {
        view.layer.cornerRadius = cornerRadius
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor
    }
    
}
