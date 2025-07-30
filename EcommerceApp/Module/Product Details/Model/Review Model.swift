//
//  Review Model.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 27/07/25.
//

import Foundation
import UIKit

class ReviewModel {
    var id: Int = 0
    var name: String
    var comments: String
    var reviewpoint: Int
    var imageName: String
    var timestamp: Date
    
    init(id: Int, name: String, comments: String, reviewpoint: Int, imageName: String, timestamp: Date) {
        self.id = id
        self.name = name
        self.comments = comments
        self.reviewpoint = reviewpoint
        self.imageName = imageName
        self.timestamp = timestamp
    }
    
    // Dummy Data Generator
    class func generateDummyReviews() -> [ReviewModel] {
        return [
            ReviewModel(id: 1,
                        name: "Hariom Sharma",
                        comments: "Great quality and fast delivery!",
                        reviewpoint: 5,
                        imageName: "person1",
                        timestamp: Date(timeIntervalSinceNow: -3600)),
            ReviewModel(id: 2,
                        name: "Dhruv Vaishnav",
                        comments: "Product is good, but packaging could be better.",
                        reviewpoint: 4,
                        imageName: "person2",
                        timestamp: Date(timeIntervalSinceNow: -86400)),
            ReviewModel(id: 3,
                        name: "Dev Sharma",
                        comments: "Not satisfied with the product.",
                        reviewpoint: 2,
                        imageName: "person3",
                        timestamp: Date(timeIntervalSinceNow: -172800)),
            ReviewModel(id: 4, name: "Ashish Sharma",
                        comments: "Amazing experience, totally worth it!",
                        reviewpoint: 5,
                        imageName: "person4",
                        timestamp: Date(timeIntervalSinceNow: -300000)),
            ReviewModel(id: 5, name: "Nikhil Gurjar",
                        comments: "Okay for the price.",
                        reviewpoint: 3,
                        imageName: "person5",
                        timestamp: Date(timeIntervalSinceNow: -604800))
        ]
    }
}

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
