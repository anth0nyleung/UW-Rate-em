//
//  CourseVC.swift
//  UW-rate_em
//
//  Created by Anthony Leung on 2/18/19.
//  Copyright © 2019 Anthony Leung. All rights reserved.
//

import UIKit
import FirebaseAuth

class CourseVC: UIViewController {
    
    var courseNumber : UILabel! = UILabel()
    var ratingLabel : UILabel! = UILabel()
    var courseName : UILabel! = UILabel()
    var gpa : UILabel! = UILabel()
    var addCommentBtn : UIButton! = UIButton()
    var addAssignmentBtn : UIButton! = UIButton()
    var assignmentsLabel : UILabel! = UILabel()
    var commentsLabel : UILabel! = UILabel()
    var assignments : UITableView! = UITableView()
    var comments : UITableView! = UITableView()
    var dismissBtn : UIButton! = UIButton()
    var moreBtn : UIButton! = UIButton()
    
    var course : Course! 
    var assignmentsList = [Assignment]()
    var commentsList = [Comment]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red:0.81, green:0.45, blue:0.45, alpha:1.0)
        
        self.setupComponents()
        self.activateConstraints()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.getAllAssignments()
        self.getAllComments()
        self.assignments.reloadData()
        self.comments.reloadData()
    }
    
    func setupComponents() {
        
        self.view.addSubview(self.courseNumber)
        self.view.addSubview(self.courseName)
        self.view.addSubview(self.gpa)
        self.view.addSubview(self.ratingLabel)
        self.view.addSubview(self.assignmentsLabel)
        self.view.addSubview(self.commentsLabel)
        self.view.addSubview(self.assignments)
        self.view.addSubview(self.comments)
        self.view.addSubview(self.dismissBtn)
        self.view.addSubview(self.moreBtn)
        self.view.addSubview(self.addAssignmentBtn)
        self.view.addSubview(self.addCommentBtn)
        
        
        self.courseName.translatesAutoresizingMaskIntoConstraints = false
        self.courseNumber.translatesAutoresizingMaskIntoConstraints = false
        self.gpa.translatesAutoresizingMaskIntoConstraints = false
        self.ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.assignmentsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.commentsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.assignments.translatesAutoresizingMaskIntoConstraints = false
        self.comments.translatesAutoresizingMaskIntoConstraints = false
        self.dismissBtn.translatesAutoresizingMaskIntoConstraints = false
        self.addAssignmentBtn.translatesAutoresizingMaskIntoConstraints = false
        self.addCommentBtn.translatesAutoresizingMaskIntoConstraints = false
        self.moreBtn.translatesAutoresizingMaskIntoConstraints = false
        
        // Course Number
        self.courseNumber.font = UIFont(name: "Futura", size: 40)
        self.courseNumber.text = self.course.courseNumber
        self.courseNumber.textAlignment = .left

        // Course Name
        self.courseName.font = UIFont(name: "Futura", size: 28)
        self.courseName.text = self.course.courseName
        self.courseName.textAlignment = .center
        
        // GPA
        self.ratingLabel.text = "GPA"
        self.ratingLabel.font = UIFont(name: "Futura", size: 16)
        
        self.ratingLabel.textAlignment = .center
        self.gpa.font = UIFont(name: "Futura", size: 50)
        self.gpa.text = String(format: "%.2f", self.course.courseRating!)
        self.gpa.textAlignment = .center
        self.gpa.textColor = .black
        
        // More Button
        self.moreBtn.setImage(UIImage(named: "more"), for: .normal)
        self.moreBtn.addTarget(self, action: #selector(moreBtnPressed(sender :)), for: .touchUpInside)
        
        //Dimiss Button
        self.dismissBtn.setImage(UIImage(named: "cancel"), for: .normal)
        self.dismissBtn.addTarget(self, action: #selector(dismissBtnPressed(sender :)), for: .touchUpInside)
        
        // Add buttons
        self.addCommentBtn.setImage(UIImage(named: "add"), for: .normal)
        self.addCommentBtn.addTarget(self, action: #selector(addCommentBtnPressed(sender :)), for: .touchUpInside)
        self.addAssignmentBtn.setImage(UIImage(named: "add"), for: .normal)
        self.addAssignmentBtn.addTarget(self, action: #selector(addAssignmentBtnPressed(sender :)), for: .touchUpInside)
        
        // Assignment Table
        self.assignmentsLabel.font = UIFont(name: "Futura", size: 20)
        self.assignmentsLabel.text = "Assignments"
        self.assignmentsLabel.textAlignment = .left
        
        self.assignments.register(AssignmentCell.self, forCellReuseIdentifier: "assignmentCell")
        self.assignments.delegate = self
        self.assignments.dataSource = self
        self.assignments.backgroundColor = UIColor(red:1.00, green:0.80, blue:0.80, alpha:1.0)
        self.assignments.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 20)
        self.assignments.separatorInsetReference = .fromAutomaticInsets
        self.assignments.rowHeight = 50
        self.assignments.estimatedRowHeight = 70
        
        // Comments Table
        self.commentsLabel.font = UIFont(name: "Futura", size: 20)
        self.commentsLabel.text = "Comments & Ratings"
        self.commentsLabel.textAlignment = .left
        
        self.comments.register(CommentCell.self, forCellReuseIdentifier: "commentCell")
        self.comments.delegate = self
        self.comments.dataSource = self
        self.comments.backgroundColor = UIColor(red:1.00, green:0.80, blue:0.80, alpha:1.0)
        self.comments.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 20)
        self.comments.separatorInsetReference = .fromAutomaticInsets
        self.comments.rowHeight = 50
        self.comments.estimatedRowHeight = 70
        
        
    }
    
    func activateConstraints() {
        
        let LabelConstraint = [self.courseNumber.topAnchor.constraint(equalTo: self.view.topAnchor, constant:75),
                               self.courseNumber.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
                               self.courseNumber.widthAnchor.constraint(equalToConstant: 250),
                               self.courseNumber.heightAnchor.constraint(equalToConstant: 60),
                                  
                               self.courseName.topAnchor.constraint(equalTo: self.courseNumber.bottomAnchor, constant:40),
                               self.courseName.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                               self.courseName.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
                               self.courseName.heightAnchor.constraint(equalToConstant: 50),
                               
                               self.ratingLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
                               self.ratingLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
                               self.ratingLabel.widthAnchor.constraint(equalToConstant: 150),
                               self.ratingLabel.heightAnchor.constraint(equalToConstant: 20),
                               
                               self.gpa.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
                               self.gpa.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
                               self.gpa.widthAnchor.constraint(equalToConstant: 150),
                               self.gpa.heightAnchor.constraint(equalToConstant: 70),
                               
                               self.assignmentsLabel.topAnchor.constraint(equalTo: self.courseName.bottomAnchor, constant: 20),
                               self.assignmentsLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
                               self.assignmentsLabel.widthAnchor.constraint(equalToConstant: 200),
                               self.assignmentsLabel.heightAnchor.constraint(equalToConstant: 50),
                               
                               
                               self.commentsLabel.topAnchor.constraint(equalTo: self.assignments.bottomAnchor, constant: 20),
                               self.commentsLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
                               self.commentsLabel.widthAnchor.constraint(equalToConstant: 200),
                               self.commentsLabel.heightAnchor.constraint(equalToConstant: 40)]
        
        let BtnConstraint = [self.dismissBtn.widthAnchor.constraint(equalToConstant: 30),
                             self.dismissBtn.heightAnchor.constraint(equalToConstant: 30),
                             self.dismissBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                             self.dismissBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 45),
                             
                             
                             self.addCommentBtn.widthAnchor.constraint(equalToConstant: 20),
                             self.addCommentBtn.heightAnchor.constraint(equalToConstant: 20),
                             self.addCommentBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
                             self.addCommentBtn.topAnchor.constraint(equalTo: self.assignments.bottomAnchor, constant: 35),
                             
                             self.addAssignmentBtn.widthAnchor.constraint(equalToConstant: 20),
                             self.addAssignmentBtn.heightAnchor.constraint(equalToConstant: 20),
                             self.addAssignmentBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
                             self.addAssignmentBtn.topAnchor.constraint(equalTo: self.courseName.bottomAnchor, constant: 35),
                             
                             self.moreBtn.widthAnchor.constraint(equalToConstant: 30),
                             self.moreBtn.heightAnchor.constraint(equalToConstant: 30),
                             self.moreBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25),
                             self.moreBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 45)
                             ]

        let TableConstraint = [self.assignments.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                               self.assignments.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                               self.assignments.topAnchor.constraint(equalTo: self.assignmentsLabel.bottomAnchor, constant: 5),
                               self.assignments.heightAnchor.constraint(equalToConstant: 200),
                               
                               self.comments.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                               self.comments.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                               self.comments.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                               self.comments.topAnchor.constraint(equalTo: self.commentsLabel.bottomAnchor, constant:5)]
        
        
        NSLayoutConstraint.activate(LabelConstraint)
        NSLayoutConstraint.activate(BtnConstraint)
        NSLayoutConstraint.activate(TableConstraint)
        
    }
    
    func reloadTables() {
        self.getAllAssignments()
        self.getAllComments()
        self.assignments.reloadData()
        self.comments.reloadData()
    }
    
    @objc func addCommentBtnPressed(sender : UIButton) {
        if Auth.auth().currentUser != nil {
            let alertController = UIAlertController(title: "Leave a comment 🤬😄", message: nil, preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Submit", style: .default) {
                (_) in
                let commentTextField = alertController.textFields![0]
                let ratingTextField = alertController.textFields![1]
                print(commentTextField.text ?? "")
                print(ratingTextField.text ?? "")
                
                if commentTextField.text == "" || ratingTextField.text == "" {
                    // Alert : Field are empty
                    let alertController = UIAlertController(title: "Alert", message: "Please fill in all fields", preferredStyle: .alert)
                    
                    let a = UIAlertAction(title: "Dismiss", style: .destructive) { (action:UIAlertAction) in
                        print("You've pressed the destructive");
                    }
                    
                    alertController.addAction(a)
                    self.present(alertController, animated: true, completion: nil)
                }
                else {
                    if ratingTextField.text!.isDouble() {
                        DataBase.instance.createCommentsForCourse(courseID: self.course.courseID, comment: commentTextField.text!, rating: Double(ratingTextField.text!)!,completion: {
                            (success) in
                            if success {
                                let newCount = Int(self.commentsList.count+1) + 1
                                let newRating = (self.course.courseRating * Double(self.commentsList.count+1) + Double(ratingTextField.text!)!) / Double(newCount)
                                
                                self.course.courseRating = newRating
                                self.gpa.text = String(format: "%.2f", newRating)
                                
                                DataBase.instance.updateCourseRating(courseID: self.course.courseID, newRating: newRating, newRatingCount: newCount, completion: {
                                    (success) in
                                    if success {
                                        self.reloadTables()
                                    }
                                })
                            }
                        })
                    }
                    else {
                        let alertController = UIAlertController(title: "Alert", message: "Rating must be between 1.0 - 5.0", preferredStyle: .alert)
                        
                        let a = UIAlertAction(title: "Dismiss", style: .destructive) { (action:UIAlertAction) in
                            print("You've pressed the destructive");
                        }
                        
                        alertController.addAction(a)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
            alertController.addTextField { (textField) in
                textField.placeholder = "Comment"
            }
            alertController.addTextField { (textField) in
                textField.placeholder = "Rating (1.0 - 5.0)"
            }

            alertController.addAction(submitAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            let alertController = UIAlertController(title: "Alert", message: "Visitor cannot comment", preferredStyle: .alert)
            
            let a = UIAlertAction(title: "Okay", style: .destructive) { (action:UIAlertAction) in
                print("You've pressed the destructive");
            }
            
            alertController.addAction(a)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func addAssignmentBtnPressed(sender : UIButton) {
        
        if Auth.auth().currentUser != nil{
            let vc = AddNewAssignmentVC()
            vc.courseID = self.course.courseID
            present(vc, animated: true, completion: nil)
        }
        else {
            let alertController = UIAlertController(title: "Alert", message: "Visitor cannot add new assignments", preferredStyle: .alert)
            
            let a = UIAlertAction(title: "Okay", style: .destructive) { (action:UIAlertAction) in
                print("You've pressed the destructive");
            }
            
            alertController.addAction(a)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func dismissBtnPressed(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func moreBtnPressed(sender: UIButton) {
        let alert = UIAlertController(title: "More", message: "Please Select an Option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Save to my course", style: .default, handler: {
            (_) in
            if Auth.auth().currentUser == nil {
                let alertController = UIAlertController(title: "Alert", message: "Visitor cannot save courses", preferredStyle: .alert)
                
                let a = UIAlertAction(title: "Okay", style: .destructive) { (action:UIAlertAction) in
                    print("You've pressed the destructive");
                }
                
                alertController.addAction(a)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                // Save to course to user profile
                DataBase.instance.saveCourseToUser(uid: Auth.auth().currentUser!.uid, courseID: self.course.courseID, completion: {
                    (success) in
                    if success {
                        let alertController = UIAlertController(title: "Success!", message: "You have saved this course", preferredStyle: .alert)
                        
                        let a = UIAlertAction(title: "Okay", style: .destructive) { (action:UIAlertAction) in
                            print("You've pressed the destructive");
                        }
                        
                        alertController.addAction(a)
                        self.present(alertController, animated: true, completion: nil)
                    }
                })
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func getAllAssignments() {
        DataBase.instance.getAllAssignmentsWithCourseID(courseID: self.course.courseID) {
            (res) in
            self.assignmentsList = res
            self.assignmentsList.sort(by: { (a, b) -> Bool in
                a.assignmentName < b.assignmentName
            })
            self.assignments.reloadData()
        }
    }
    
    func getAllComments() {
        DataBase.instance.getAllCourseComments(courseID: self.course.courseID) {
            (res) in
            self.commentsList = res
            self.commentsList.sort(by: { (a, b) -> Bool in
                a.rating < b.rating
            })
            self.comments.reloadData()
        }
    }
}


extension CourseVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == assignments {
            return self.assignmentsList.count
        }
        else {
            return self.commentsList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == assignments {
            let cell = self.assignments.dequeueReusableCell(withIdentifier: "assignmentCell", for: indexPath) as! AssignmentCell
            cell.configure(assignment: self.assignmentsList[indexPath.row])
            return cell
        }
        else {
            let cell = self.comments.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell
            cell.configure(comment: commentsList[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let assignmentVC = AssignmentVC()
        assignmentVC.assignment = self.assignmentsList[indexPath.row]
        assignmentVC.modalTransitionStyle = .flipHorizontal
        present(assignmentVC, animated: true, completion: nil)
    }
    
    
}
