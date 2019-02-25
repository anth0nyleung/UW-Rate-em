//
//  Database.swift
//  UW-rate_em
//
//  Created by Anthony Leung on 2/18/19.
//  Copyright © 2019 Anthony Leung. All rights reserved.
//


import Foundation
import Firebase

let DB_REF = Database.database().reference()

class DataBase {
    static let instance = DataBase()
    
    private var _REF_BASE = DB_REF
    private var _REF_USERS = DB_REF.child("Users")
    private var _REF_COURSES = DB_REF.child("Courses")
    private var _REF_ASSIGNMENTS = DB_REF.child("Assignments")
    private var _REF_COMMENTS = DB_REF.child("Comments")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_COURSES: DatabaseReference {
        return _REF_COURSES
    }
    
    var REF_ASSIGNMENTS: DatabaseReference {
        return _REF_ASSIGNMENTS
    }
    
    var REF_COMMENTS : DatabaseReference {
        return _REF_COMMENTS
    }
    
    /*  ------------------------------------- Users ---------------------------------------------- */
    
    func createUsers (uid : String, metadata : [String : Any]) {
        REF_USERS.child("\(uid)/metadata").setValue(metadata)
    }
        
    func getUserDisplayName (uid : String, completion : @escaping (_ displayName : String) -> ()) {
        REF_USERS.child("\(uid)/metadata").observeSingleEvent(of: .value) {
            (ds) in
            
            guard let result = ds.value as? NSDictionary else {
                completion("")
                return
            }
            completion(result["displayName"] as! String)
        }
    }
    
    func saveCourseToUser(uid : String, courseID : String, completion : @escaping (_: Bool) -> ()) {
        REF_USERS.child("\(uid)/courses/\(courseID)").setValue(true)
        completion(true)
    }
    
    func saveAssignmentToUser(uid : String, assignmentID : String, completion : @escaping(_: Bool)-> ()) {
        print(assignmentID)
        REF_USERS.child("\(uid)/assignments/\(assignmentID)").setValue(true)
        completion(true)
    }
    
    func getCoursesWithIDs(ids : [String], completion : @escaping (_:[Course])->()) {
        var mycourses = [Course]()
        REF_COURSES.observeSingleEvent(of: .value, with: {
            (ds) in
            guard let courses = ds.children.allObjects as? [DataSnapshot] else { return }

            for c in courses {
                let id = c.key
                if ids.contains(id) {
                    var data = c.value as! [String: Any]
                    var metadata = data["metadata"]! as! [String: Any]
                    
                    let courseNumber = metadata["courseNumber"] as! String
                    let courseName = metadata["courseName"] as! String
                    let rating = metadata["rating"] as! Double
                    let ratingCount = metadata["ratingCount"] as! Int
                    
                    mycourses.append(Course(courseID: id, courseName: courseName, courseNumber: courseNumber, courseRating: rating, courseRatingCount : ratingCount, assignments: [Assignment](), comments: [String]()))
                }
            }
            completion(mycourses)
        })
    }
    
    func getUserCourses(uid : String, completion : @escaping (_:[Course])->()) {
        // Get all courseIDs
        var myCourse = [Course]()
        REF_USERS.child("\(uid)/courses").observe(.value) {
            (ds) in
            guard let courses = ds.value as? NSDictionary else { return }
            var ids = [String]()
            
            for c in courses { ids.append(c.key as! String) }
            
            // Loop through all course and get course with the specfic courseIDs
            self.getCoursesWithIDs(ids: ids, completion: {
                (res) in
                myCourse = res
                completion(myCourse)
            })
        }
    }
    
    func getUserAssignments(uid : String, completion : @escaping (_:[Assignment])->()) {
        // Get all assignments
        var myAssignments = [Assignment]()
        
        REF_USERS.child("\(uid)/assignments").observe(.value) {
            (ds) in
            guard let courses = ds.value as? NSDictionary else { return }
            var ids = [String]()
            
            for c in courses { ids.append(c.key as! String) }
            // Loop through all course and get course with the specfic courseIDs
            self.getAssignmentWithIDs(assignmentID: ids, completion: {
                (res) in
                myAssignments = res
                completion(myAssignments)
            })
        }
    }
    
    /*  ------------------------------------ Course --------------------------------------------- */
    func isCourseExist(inputCourseNumber: String, completion : @escaping (_  : Bool) -> ()) {
        REF_COURSES.observe(.value) {
            (ds) in
            var exist = false
            guard let result = ds.children.allObjects as? [DataSnapshot] else { return }
            for each in result {
                let courseNumber = each.childSnapshot(forPath: "metadata/courseNumber").value as! String
                if courseNumber == inputCourseNumber {
                    exist = true
                }
            }
            completion(exist)
        }
    }
    
    func updateCourseRating(courseID : String, newRating : Double,
                                newRatingCount : Int, completion : @escaping (_:Bool)->()) {
        
        REF_COURSES.child("\(courseID)/metadata/rating").setValue(newRating)
        REF_COURSES.child("\(courseID)/metadata/ratingCount").setValue(newRatingCount)
        completion(true)
    }
    
    func createCourse(courseID : String, metadata:[String: Any], completion : @escaping (_ : Bool) ->()) {
        self.isCourseExist(inputCourseNumber: metadata["courseNumber"] as! String) {
            (isExist) in
            if !isExist {
                self.REF_COURSES.child("\(courseID)/metadata").setValue(metadata)
                completion(true)
            }
            completion(false)
        }
    }
    
    func getAllCourses(completion : @escaping (_: [Course]) -> ()) {
        
        var courseList = [Course]()
        
        REF_COURSES.observeSingleEvent(of: .value) {
            (ds) in
            guard let courses = ds.value as? NSDictionary else { return }
            
            for c in courses {
                var data = c.value as! [String: Any]
                var metadata = data["metadata"]! as! [String: Any]
     
                let courseID = c.key as! String
                let courseNumber = metadata["courseNumber"] as! String
                let courseName = metadata["courseName"] as! String
                let rating = metadata["rating"] as! Double
                let ratingCount = metadata["ratingCount"] as! Int

                courseList.append(Course(courseID: courseID, courseName: courseName, courseNumber: courseNumber, courseRating: rating, courseRatingCount : ratingCount, assignments: [Assignment](), comments: [String]()))
            }
            
            completion(courseList)
        }
    }
    
    func getCourseID(courseNumber : String, completion : @escaping (_ : String) -> ()) {
        REF_COURSES.observe(.value) {
            (ds) in
            
            guard let courses = ds.children.allObjects as? [DataSnapshot] else { return }
            for c in courses {
                let cNum = c.childSnapshot(forPath: "metadata/courseNumber").value as! String
                
                if cNum == courseNumber {
                    let id = c.key
                    completion(id)
                }
            }
            completion("")
        }
    }
    
    /*  ----------------------------------------------- Assignments ---------------------------------------------------- */
    
    func createAssignment(assignmentID: String, courseID : String,
                          metadata : [String : Any], completion : @escaping(_:Bool) ->()) {
        let assignmentID = REF_ASSIGNMENTS.childByAutoId().key!
        REF_ASSIGNMENTS.child("\(assignmentID)/metadata").setValue(metadata)
        REF_COURSES.child("\(courseID)/assignments/\(assignmentID)").setValue(["assignmentName": metadata["assignmentName"]])
        completion(true)
    }
    
    func updateAssignmentRating(assignmentID : String, newRating : Double,
                                newRatingCount : Int, completion : @escaping (_:Bool)->()) {
        
        REF_ASSIGNMENTS.child("\(assignmentID)/metadata/rating").setValue(newRating)
        REF_ASSIGNMENTS.child("\(assignmentID)/metadata/ratingCount").setValue(newRatingCount)
        completion(true)
    }
    
    func getAllAssignmentsWithCourseID(courseID : String, completion : @escaping (_: [Assignment]) ->()) {
        var res = [Assignment]()
        
        REF_COURSES.child("\(courseID)/assignments").observeSingleEvent(of: .value) {
            (ds) in
            guard let assignments = ds.value as? NSDictionary else { return }
            var id = [String]()
            
            for a in assignments {
                id.append(a.key as! String)
            }
            
            self.getAssignmentWithIDs(assignmentID: id, completion: {
                (list) in
                res = list
                completion(res)
            })
        }
    }
    
    func getAssignmentWithIDs(assignmentID: [String], completion : @escaping (_: [Assignment])->()) {
        var res = [Assignment]()
        REF_ASSIGNMENTS.observeSingleEvent(of: .value) {
            (ds) in
            guard let assignments = ds.children.allObjects as? [DataSnapshot] else { return }

            for a in assignments {
                let id = a.key
                if assignmentID.contains(id) {
                    var data = a.value as! [String: Any]
                    var metadata = data["metadata"]! as! [String: Any]
                    
                    let courseID = metadata["courseID"] as! String
                    let assignmentName = metadata["assignmentName"] as! String
                    let description = metadata["description"] as! String
                    let rating = metadata["rating"] as! Double
                    let ratingCount = metadata["ratingCount"] as! Int
                    
                    res.append(Assignment(assignmentID: id, courseID: courseID, assignmentName: assignmentName, description: description, rating: rating, ratingCount: ratingCount))
                    
                }
            }
            completion(res)
        }
    }
    
    /*  ------------------------------------- Comments --------------------------------------------- */
    func createCommentsForCourse(courseID : String, comment : String, rating: Double, completion : @escaping (_: Bool)->()) {
        // Add new comment at the comment field of the course
        let commentID = REF_COURSES.child("\(courseID)/comments").childByAutoId().key!
        REF_COURSES.child("\(courseID)/comments/\(commentID)").setValue(["content": comment, "rating":rating])
        completion(true)
    }
    
    func createCommentsForAssignment(assignmentID : String, comment : String, rating: Double, completion : @escaping (_: Bool)->()) {
        // Add new comment at the comment field of the assignment
        let commentID = REF_ASSIGNMENTS.child("\(assignmentID)/comments").childByAutoId().key!
        REF_ASSIGNMENTS.child("\(assignmentID)/comments/\(commentID)").setValue(["content": comment, "rating":rating])
        completion(true)
    }
    
    func getAllCourseComments(courseID : String, completion : @escaping (_ : [Comment]) -> ()) {
        var commentList = [Comment]()
        
        REF_COURSES.child("\(courseID)/comments").observeSingleEvent(of: .value) {
            (ds) in
            guard let comments = ds.value as? NSDictionary else { return }
            
            for c in comments {
                var data = c.value as! [String: Any]
                print(data)
                let content = data["content"] as! String
                let rating = data["rating"] as! Double
                
                commentList.append(Comment(rating: rating, content: content))
            }
            
            completion(commentList)
        }
    }
    
    func getAllAssignmentComments(assignmetID : String, completion : @escaping (_ : [Comment])-> ()) {
        var commentList = [Comment]()
        
        REF_ASSIGNMENTS.child("\(assignmetID)/comments").observeSingleEvent(of: .value) {
            (ds) in
            guard let comments = ds.value as? NSDictionary else { return }
            
            for c in comments {
                var data = c.value as! [String: Any]
                let content = data["content"] as! String
                let rating = data["rating"] as! Double
                
                commentList.append(Comment(rating: rating, content: content))
            }
            
            completion(commentList)
        }
    }
}

