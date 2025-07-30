//
//  AddressModel.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 18/07/25.
//

import Foundation
import UIKit

class Address : NSObject
{
    var strFirstName: String?
    var strLastName: String?
    var strEmail: String?
    var intAge: Int?
    var strState: String?
    var strCity: String?
    var strAddress1 : String?
    var strAddress2 : String?
    var intPincode : Int?
    var intMobileNo : Int?
    
    init(strFirstName: String? = nil, strLastName: String? = nil, strEmail: String? = nil, intAge: Int? = nil, strState: String? = nil, strCity: String? = nil, strAddress1: String? = nil, strAddress2: String? = nil, intPincode: Int? = nil, intMobileNo : Int? = nil) {
        self.strFirstName = strFirstName
        self.strLastName = strLastName
        self.strEmail = strEmail
        self.intAge = intAge
        self.strState = strState
        self.strCity = strCity
        self.strAddress1 = strAddress1
        self.strAddress2 = strAddress2
        self.intPincode = intPincode
        self.intMobileNo = intMobileNo
    }
}
