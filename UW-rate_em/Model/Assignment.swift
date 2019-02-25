//
//  Assignment.swift
//  UW-rate_em
//
//  Created by Anthony Leung on 2/20/19.
//  Copyright © 2019 Anthony Leung. All rights reserved.
//

import Foundation

class Assignment {
    
    var assignmentID : String!
    var courseID : String!
    var assignmentName : String!
    var description : String!
    var rating : Double!
    var ratingCount : Int!
    
    init(assignmentID : String, courseID : String, assignmentName: String, description: String, rating: Double, ratingCount: Int) {
        
        self.assignmentID = assignmentID
        self.courseID = courseID
        self.assignmentName = assignmentName
        self.description = description
        self.rating = rating
        self.ratingCount = ratingCount
    }
    
}
