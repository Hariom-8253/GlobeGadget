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
    var selectedState: String?
    var selectedCity: String?
    
    
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
    
    // New
    
    static let stateCityData: [String: [String]] = [
        "Andhra Pradesh": ["Visakhapatnam", "Vijayawada", "Guntur"],
        "Arunachal Pradesh": ["Itanagar", "Tawang", "Naharlagun"],
        "Assam": ["Guwahati", "Silchar", "Dibrugarh"],
        "Bihar": ["Patna", "Gaya", "Bhagalpur"],
        "Chhattisgarh": ["Raipur", "Bilaspur", "Durg"],
        "Goa": ["Panaji", "Margao", "Vasco da Gama"],
        "Gujarat": ["Ahmedabad", "Surat", "Vadodara"],
        "Haryana": ["Gurgaon", "Faridabad", "Panipat"],
        "Himachal Pradesh": ["Shimla", "Manali", "Dharamshala"],
        "Jharkhand": ["Ranchi", "Jamshedpur", "Dhanbad"],
        "Karnataka": ["Bengaluru", "Mysuru", "Mangalore"],
        "Kerala": ["Kochi", "Thiruvananthapuram", "Kozhikode"],
        "Madhya Pradesh": ["Bhopal", "Indore", "Jabalpur"],
        "Maharashtra": ["Mumbai", "Pune", "Nagpur"],
        "Manipur": ["Imphal", "Bishnupur", "Thoubal"],
        "Meghalaya": ["Shillong", "Tura", "Nongpoh"],
        "Mizoram": ["Aizawl", "Lunglei", "Champhai"],
        "Nagaland": ["Kohima", "Dimapur", "Mokokchung"],
        "Odisha": ["Bhubaneswar", "Cuttack", "Rourkela"],
        "Punjab": ["Amritsar", "Ludhiana", "Jalandhar"],
        "Rajasthan": ["Jaipur", "Jodhpur", "Udaipur"],
        "Sikkim": ["Gangtok", "Namchi", "Geyzing"],
        "Tamil Nadu": ["Chennai", "Coimbatore", "Madurai"],
        "Telangana": ["Hyderabad", "Warangal", "Nizamabad"],
        "Tripura": ["Agartala", "Udaipur", "Dharmanagar"],
        "Uttar Pradesh": ["Lucknow", "Kanpur", "Varanasi"],
        "Uttarakhand": ["Dehradun", "Haridwar", "Nainital"],
        "West Bengal": ["Kolkata", "Siliguri", "Durgapur"]
    ]
    
    static var stateList: [String] {
        return Array(stateCityData.keys).sorted()
    }
    
    static func cities(forState state: String) -> [String] {
        return stateCityData[state] ?? []
    }
}
