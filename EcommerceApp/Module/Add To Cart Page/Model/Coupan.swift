//
//  Coupan.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 27/07/25.
//

import Foundation


class Coupon {
    var code: String
    var discountAmount: Double
    var discountType: DiscountType
    var isActive: Bool
    
    enum DiscountType {
        case percentage
        case fixedAmount
    }
    
    init(code: String, discountAmount: Double, discountType: DiscountType, isActive: Bool = true) {
        self.code = code
        self.discountAmount = discountAmount
        self.discountType = discountType
        self.isActive = isActive
    }
    
    class func generateCoupons() -> [Coupon] {
        return [
            Coupon(code: "WELCOME10", discountAmount: 10, discountType: .percentage),
            Coupon(code: "FESTIVE50", discountAmount: 50, discountType: .fixedAmount),
            Coupon(code: "SAVE20", discountAmount: 20, discountType: .percentage),
            Coupon(code: "NEWUSER25", discountAmount: 25, discountType: .fixedAmount),
            Coupon(code: "SUMMER15", discountAmount: 15, discountType: .percentage),
            Coupon(code: "OFF100", discountAmount: 100, discountType: .fixedAmount),
            Coupon(code: "TRY5", discountAmount: 5, discountType: .percentage),
            Coupon(code: "SHOP75", discountAmount: 75, discountType: .fixedAmount),
            Coupon(code: "BIGSALE30", discountAmount: 30, discountType: .percentage),
            Coupon(code: "EXTRA20", discountAmount: 20, discountType: .fixedAmount)
        ]
    }
}

