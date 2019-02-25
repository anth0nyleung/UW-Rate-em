//
//  AddNewAssignmentVC.swift
//  UW-rate_em
//
//  Created by Anthony Leung on 2/18/19.
//  Copyright © 2019 Anthony Leung. All rights reserved.
//

import UIKit
import FirebaseAuth

class AddNewAssignmentVC: UIViewController {

    var header : UILabel! = UILabel()
    var dismissBtn : UIButton! = UIButton()
    var assignment : UITextField! = UITextField()
    var descriptionView : UITextView! = UITextView()
    var rating : UITextField! = UITextField()
    var completeBtn : UIButton! = UIButton()
    
    var courseID : String! = ""
    
    let placeholderColor : UIColor = UIColor(red:0.63, green:0.45, blue:0.45, alpha:1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red:0.76, green:0.00, blue:0.00, alpha:1.0)
        
        self.setupComponents()
        self.activateConstraints()
    
    }
    
    func setupComponents() {
        
        self.view.addSubview(self.header)
        self.view.addSubview(self.completeBtn)
        self.view.addSubview(self.assignment)
        self.view.addSubview(self.descriptionView)
        self.view.addSubview(self.rating)
        self.view.addSubview(self.dismissBtn)
        
        self.header.translatesAutoresizingMaskIntoConstraints = false
        self.completeBtn.translatesAutoresizingMaskIntoConstraints = false
        self.assignment.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionView.translatesAutoresizingMaskIntoConstraints = false
        self.rating.translatesAutoresizingMaskIntoConstraints = false
        self.dismissBtn.translatesAutoresizingMaskIntoConstraints = false
        
        //Header
        self.header.font = UIFont(name: "Futura", size: 30)
        self.header.text = "Add New Assignment"
        self.header.textAlignment = .center
        
        
        // Complete Btn
        let completeBtnTitle = NSAttributedString(string: "Submit",
                                                  attributes: [.font : UIFont(name: "Futura", size: 20)!])
        self.completeBtn.backgroundColor = UIColor(red:0.90, green:0.49, blue:0.49, alpha:1.0)
        self.completeBtn.setAttributedTitle(completeBtnTitle, for: .normal)
        self.completeBtn.clipsToBounds = true
        self.completeBtn.addTarget(self, action: #selector(submitBtnPressed(sender:)), for: .touchUpInside)
        
        // Assignment text field
        self.assignment.attributedPlaceholder = NSAttributedString(string: "Assignment (e.g. Cache Simulator)",
                                                                   attributes : [.font : UIFont(name: "Futura", size: 20)!])
        let futura = UIFont.init(name: "Futura", size: 20)!
        self.assignment.font = futura
        self.assignment.backgroundColor = UIColor(red:0.89, green:0.60, blue:0.60, alpha:1.0)
        self.assignment.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
        self.assignment.isSecureTextEntry = false
        self.assignment.autocapitalizationType = .none
        self.assignment.autocorrectionType = .no
        self.assignment.borderStyle = .none
        
        //Description View
        self.descriptionView.textAlignment = NSTextAlignment.justified
        self.descriptionView.backgroundColor = UIColor(red:0.89, green:0.60, blue:0.60, alpha:1.0)
        self.descriptionView.autocapitalizationType = .sentences
        self.descriptionView.isSelectable = true
        self.descriptionView.isEditable = true
        self.descriptionView.font = futura
        self.descriptionView.attributedText = NSAttributedString(string: "Descirption", attributes : [.font : UIFont(name: "Futura", size: 20)!])
        self.descriptionView.text = "Description"
        self.descriptionView.textColor = placeholderColor
        self.descriptionView.delegate = self
        self.descriptionView.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
        
        // Rating text field
        self.rating.attributedPlaceholder = NSAttributedString(string: "Rating (1-5)", attributes: [.font : UIFont(name: "Futura", size: 20)!])
        self.rating.font = futura
        self.rating.backgroundColor = UIColor(red:0.89, green:0.60, blue:0.60, alpha:1.0)
        self.rating.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
        self.rating.autocapitalizationType = .none
        self.rating.autocorrectionType = .no
        self.rating.borderStyle = .none
        
        // Dismiss Button
        self.dismissBtn.setImage(UIImage(named: "cancel"), for: .normal)
        self.dismissBtn.addTarget(self, action: #selector(dismissBtnPressed(sender :)), for: .touchUpInside)
    }
    func activateConstraints() {
        
        let headerConstraint = [self.header.topAnchor.constraint(equalTo: self.view.topAnchor, constant : 160),
                                self.header.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                self.header.widthAnchor.constraint(equalToConstant: 350),
                                self.header.heightAnchor.constraint(equalToConstant: 50)]
        
        let BtnConstraint = [self.completeBtn.widthAnchor.constraint(equalToConstant: 300),
                             self.completeBtn.heightAnchor.constraint(equalToConstant: 40),
                             self.completeBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                             self.completeBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 510),
                             
                             self.dismissBtn.widthAnchor.constraint(equalToConstant: 30),
                             self.dismissBtn.heightAnchor.constraint(equalToConstant: 30),
                             self.dismissBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                             self.dismissBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 45)]
        
        let assignmentConstraint = [self.assignment.widthAnchor.constraint(equalToConstant: 360),
                                    self.assignment.heightAnchor.constraint(equalToConstant: 50),
                                    self.assignment.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
                                    self.assignment.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 240)]
        
        let descriptionViewConstraint = [self.descriptionView.widthAnchor.constraint(equalToConstant: 360),
                                         self.descriptionView.heightAnchor.constraint(equalToConstant: 100),
                                         self.descriptionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
                                         self.descriptionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 310)
                                         ]
        
        let ratingConstraint = [self.rating.widthAnchor.constraint(equalToConstant: 360),
                                self.rating.heightAnchor.constraint(equalToConstant: 50),
                                self.rating.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
                                self.rating.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 430)]
        
        NSLayoutConstraint.activate(headerConstraint)
        NSLayoutConstraint.activate(BtnConstraint)
        NSLayoutConstraint.activate(assignmentConstraint)
        NSLayoutConstraint.activate(descriptionViewConstraint)
        NSLayoutConstraint.activate(ratingConstraint)
        NSLayoutConstraint.activate(BtnConstraint)
    }
    /* ------------------------------------------------------------------------------------------------------------------------------------------------------------- */

    /* Create new assignment for this course, save to users' assignment */
    @objc func submitBtnPressed(sender: UIButton) {
        if isInputValid() {
            // Create new course and rating
            print("add new course")
            let inputAssignment = self.assignment.text!
            let inputDescription = self.descriptionView.text!
            let inputRating = Double(self.rating.text!)!
            
            // Create new assignment for this course
            let assignmentID = DataBase.instance.REF_ASSIGNMENTS.childByAutoId().key!
            DataBase.instance.createAssignment(assignmentID : assignmentID, courseID : self.courseID,
                                               metadata: ["courseID" : self.courseID, "assignmentName":inputAssignment,
                                                                                    "description":inputDescription,"rating": inputRating, "ratingCount" : 1]) {
                (success) in
                DataBase.instance.saveAssignmentToUser(uid: Auth.auth().currentUser!.uid , assignmentID: assignmentID, completion: {
                    (success) in
                    self.dismiss(animated: true, completion: nil)
                })
            }
        }
        /* Not all input fields are filled in */
        else {
            let alertController = UIAlertController(title: "Alert", message: "Please fill in all fields", preferredStyle: .alert)
            
            let a = UIAlertAction(title: "Dismiss", style: .destructive) { (action:UIAlertAction) in
                print("You've pressed the destructive");
            }
            
            alertController.addAction(a)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    /* Dismiss view */
    @objc func dismissBtnPressed(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /* Input Validation */
    func isInputValid() -> Bool {
        if self.assignment.text == nil || self.descriptionView.text == nil || self.rating.text == nil {
            return false
        }
        
        if self.rating.text != nil {
            if self.rating.text!.isDouble() {
                let val = Double(self.rating.text!)!
                return val <= 5.0  &&  val >= 0.0
            }
        }
        return true
    }
}

extension AddNewAssignmentVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ :UITextView) {
        if self.descriptionView.textColor == placeholderColor {
            self.descriptionView.text = ""
            self.descriptionView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.descriptionView.text.isEmpty {
            self.descriptionView.text = "Description"
            self.descriptionView.textColor = placeholderColor
        }
    }
}
