//
//  Course.swift
//  UW-rate_em
//
//  Created by Anthony Leung on 2/20/19.
//  Copyright © 2019 Anthony Leung. All rights reserved.
//

import Foundation


/* Get course ID */ 
class Course {
    
    var courseID : String!
    var courseName: String!
    var courseNumber: String!
    var courseRating: Double!
    var courseRatingCount : Int!
    var assignments: [Assignment]
    var comments : [String]
    
    init(courseID: String, courseName: String, courseNumber : String, courseRating : Double, courseRatingCount : Int, assignments : [Assignment], comments : [String]) {
        self.courseID = courseID
        self.courseName = courseName
        self.courseNumber = courseNumber
        self.courseRating = courseRating
        self.assignments = assignments
        self.comments = comments
        self.courseRatingCount = courseRatingCount
    }
    
    
    
}
