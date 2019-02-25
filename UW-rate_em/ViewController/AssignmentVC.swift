//
//  AssignmentVC.swift
//  UW-rate_em
//
//  Created by Anthony Leung on 2/18/19.
//  Copyright © 2019 Anthony Leung. All rights reserved.
//

import UIKit
import FirebaseAuth

class AssignmentVC: UIViewController {
    
    var assignment : Assignment!
    var commentList : [Comment]! = [Comment]()
    
    var assignmentLabel : UILabel! = UILabel()
    var descriptionText : UILabel! = UILabel()
    var ratingLabel : UILabel! = UILabel()
    var gpa : UILabel! = UILabel()
    var addCommentBtn : UIButton! = UIButton()
    var commentsLabel : UILabel! = UILabel()
    var comments : UITableView! = UITableView()
    var dismissBtn : UIButton! = UIButton()
    var moreBtn : UIButton! = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red:0.81, green:0.45, blue:0.45, alpha:1.0)
        
        self.getAllComments()
        self.setupComponents()
        self.activateConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getAllComments()
        self.comments.reloadData()
    }
    
    func setupComponents() {
        
        self.view.addSubview(self.assignmentLabel)
        self.view.addSubview(self.descriptionText)
        self.view.addSubview(self.ratingLabel)
        self.view.addSubview(self.gpa)
        self.view.addSubview(self.addCommentBtn)
        self.view.addSubview(self.commentsLabel)
        self.view.addSubview(self.comments)
        self.view.addSubview(self.dismissBtn)
        self.view.addSubview(self.moreBtn)
        
        self.assignmentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionText.translatesAutoresizingMaskIntoConstraints = false
        self.ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.gpa.translatesAutoresizingMaskIntoConstraints = false
        self.addCommentBtn.translatesAutoresizingMaskIntoConstraints = false
        self.commentsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.comments.translatesAutoresizingMaskIntoConstraints = false
        self.dismissBtn.translatesAutoresizingMaskIntoConstraints = false
        self.moreBtn.translatesAutoresizingMaskIntoConstraints = false
        
        // Assignment
        self.assignmentLabel.font = UIFont(name: "Futura", size: 40)
        self.assignmentLabel.text = self.assignment.assignmentName
        self.assignmentLabel.textAlignment = .left

        // Description
        self.descriptionText.font = UIFont(name: "Futura", size: 28)
        self.descriptionText.text = self.assignment.description
        self.descriptionText.textAlignment = .left
        
        
        // Rating Label
        self.ratingLabel.text = "GPA"
        self.ratingLabel.font = UIFont(name: "Futura", size: 16)
        
        self.ratingLabel.textAlignment = .center
        self.gpa.font = UIFont(name: "Futura", size: 50)
        self.gpa.text = String(format: "%.2f", self.assignment.rating!)
        self.gpa.textColor = .black
        
        // Comment Table
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
        
        // Buttons
        self.addCommentBtn.setImage(UIImage(named: "add"), for: .normal)
        self.addCommentBtn.addTarget(self, action: #selector(addCommentBtnPressed(sender :)), for: .touchUpInside)
        self.dismissBtn.setImage(UIImage(named: "cancel"), for: .normal)
        self.dismissBtn.addTarget(self, action: #selector(dismissBtnPressed(sender :)), for: .touchUpInside)
        self.moreBtn.setImage(UIImage(named: "more"), for: .normal)
        self.moreBtn.addTarget(self, action: #selector(moreBtnPressed(sender :)), for: .touchUpInside)
    }
    
    func activateConstraints() {
        
        let LabelConstraint = [self.assignmentLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant:75),
                               self.assignmentLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
                               self.assignmentLabel.widthAnchor.constraint(equalToConstant: 250),
                               self.assignmentLabel.heightAnchor.constraint(equalToConstant: 60),
                               
                               self.descriptionText.topAnchor.constraint(equalTo: self.assignmentLabel.bottomAnchor, constant:40),
                               self.descriptionText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
                               self.descriptionText.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
                               self.descriptionText.heightAnchor.constraint(equalToConstant: 60),
                               
                               self.ratingLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
                               self.ratingLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
                               self.ratingLabel.widthAnchor.constraint(equalToConstant: 150),
                               self.ratingLabel.heightAnchor.constraint(equalToConstant: 20),
                               
                               self.gpa.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
                               self.gpa.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
                               self.gpa.widthAnchor.constraint(equalToConstant: 150),
                               self.gpa.heightAnchor.constraint(equalToConstant: 70),
                            
                               self.commentsLabel.topAnchor.constraint(equalTo: self.descriptionText.bottomAnchor, constant: 20),
                               self.commentsLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
                               self.commentsLabel.widthAnchor.constraint(equalToConstant: 200),
                               self.commentsLabel.heightAnchor.constraint(equalToConstant: 40)]
        
        let BtnConstraint = [self.dismissBtn.widthAnchor.constraint(equalToConstant: 30),
                             self.dismissBtn.heightAnchor.constraint(equalToConstant: 30),
                             self.dismissBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                             self.dismissBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 45),
                             
                             self.moreBtn.widthAnchor.constraint(equalToConstant: 30),
                             self.moreBtn.heightAnchor.constraint(equalToConstant: 30),
                             self.moreBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25),
                             self.moreBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 45),
                             
                             self.addCommentBtn.widthAnchor.constraint(equalToConstant: 20),
                             self.addCommentBtn.heightAnchor.constraint(equalToConstant: 20),
                             self.addCommentBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
                             self.addCommentBtn.topAnchor.constraint(equalTo: self.descriptionText.bottomAnchor, constant: 35),]


        let TableConstraint = [self.comments.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                               self.comments.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                               self.comments.topAnchor.constraint(equalTo: self.commentsLabel.bottomAnchor, constant: 5),
                               self.comments.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)]


        NSLayoutConstraint.activate(LabelConstraint)
        NSLayoutConstraint.activate(BtnConstraint)
        NSLayoutConstraint.activate(TableConstraint)
    }

    func getAllComments() {
        DataBase.instance.getAllAssignmentComments(assignmetID: self.assignment.assignmentID, completion: { 
            (res) in
            self.commentList = res
            self.commentList.sort(by: { (a, b) -> Bool in
            a.rating < b.rating
            })
            self.comments.reloadData()
        })

    }

    func reloadTables() {
        getAllComments()
        self.comments.reloadData()
    }
    
    @objc func addCommentBtnPressed(sender : UIButton) {
        if Auth.auth().currentUser != nil {
            let alertController = UIAlertController(title: "Leave a comment 🤬😄", message: nil, preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Submit", style: .default) {
                (_) in
                let commentTextField = alertController.textFields![0]
                let ratingTextField = alertController.textFields![1]
                
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
                        DataBase.instance.createCommentsForAssignment(assignmentID: self.assignment.assignmentID, comment: commentTextField.text!, rating: Double(ratingTextField.text!)!,completion: {
                            (success) in
                            if success {
                                let newCount = Int(self.commentList.count+1) + 1
                                let newRating = ((self.assignment.rating * Double(self.commentList.count+1)) + Double(ratingTextField.text!)!) / Double(newCount)
                                print(newRating)
                                self.assignment.rating = newRating
                                self.gpa.text = String(format: "%.2f", newRating)

                                DataBase.instance.updateAssignmentRating(assignmentID: self.assignment.assignmentID, newRating: newRating, newRatingCount: newCount, completion: {
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
    
    @objc func dismissBtnPressed(sender : UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func moreBtnPressed(sender : UIButton) {
        let alert = UIAlertController(title: "More", message: "Please Select an Option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Save to my assignment", style: .default, handler: {
            (_) in
            if Auth.auth().currentUser == nil {
                let alertController = UIAlertController(title: "Alert", message: "Visitor cannot save assignment", preferredStyle: .alert)
                
                let a = UIAlertAction(title: "Okay", style: .destructive) { (action:UIAlertAction) in
                    print("You've pressed the destructive");
                }
                
                alertController.addAction(a)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                DataBase.instance.saveAssignmentToUser(uid: Auth.auth().currentUser!.uid, assignmentID: self.assignment.assignmentID!, completion: {
                    (success) in
                    
                    if success {
                        let alertController = UIAlertController(title: "Success!", message: "You have saved this assignment", preferredStyle: .alert)
                        
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
}

extension AssignmentVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.comments.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell
        cell.configure(comment: self.commentList[indexPath.row])
        return cell
    }
}
