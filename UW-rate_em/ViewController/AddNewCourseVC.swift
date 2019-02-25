//
//  AddNewCourseVController.swift
//  UW-rate_em
//
//  Created by Anthony Leung on 2/18/19.
//  Copyright © 2019 Anthony Leung. All rights reserved.
//

import UIKit
import FirebaseAuth

class AddNewCourseVC: UIViewController {
    
    var header : UILabel! = UILabel()
    var courseName: UITextField! = UITextField()
    var courseNumber: UITextField! = UITextField()
    var rating: UITextField! = UITextField()
    var submitBtn : UIButton! = UIButton()
    var dismissBtn : UIButton! = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red:0.76, green:0.00, blue:0.00, alpha:1.0)
        
        self.setupComponents()
        self.activateConstraints()
    }
    
    func setupComponents() {
        self.view.addSubview(self.header)
        self.view.addSubview(self.courseName)
        self.view.addSubview(self.courseNumber)
        self.view.addSubview(self.rating)
        self.view.addSubview(self.submitBtn)
        self.view.addSubview(self.dismissBtn)
        
        self.header.translatesAutoresizingMaskIntoConstraints = false
        self.courseName.translatesAutoresizingMaskIntoConstraints = false
        self.courseNumber.translatesAutoresizingMaskIntoConstraints = false
        self.rating.translatesAutoresizingMaskIntoConstraints = false
        self.submitBtn.translatesAutoresizingMaskIntoConstraints = false
        self.dismissBtn.translatesAutoresizingMaskIntoConstraints = false
        
        // Header
        self.header.font = UIFont(name: "Futura", size: 30)
        self.header.text = "Add New Course"
        self.header.textAlignment = .center
        
        // Course Name Field
        self.courseName.attributedPlaceholder = NSAttributedString(string: "Course Name (e.g. Programming III)", attributes: [.font : UIFont(name: "Futura", size: 20)!])
        let futura = UIFont.init(name: "Futura", size: 20)!
        self.courseName.font = futura
        self.courseName.backgroundColor = UIColor(red:0.89, green:0.60, blue:0.60, alpha:1.0)
        self.courseName.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
        self.courseName.autocapitalizationType = .none
        self.courseName.autocorrectionType = .no
        self.courseName.borderStyle = .none
        
        
        // Course Number Field
        self.courseNumber.attributedPlaceholder = NSAttributedString(string: "Course Number (e.g. CS400)",
                                                                     attributes : [.font : UIFont(name: "Futura", size: 20)!])
        self.courseNumber.font = futura
        self.courseNumber.backgroundColor = UIColor(red:0.89, green:0.60, blue:0.60, alpha:1.0)
        self.courseNumber.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
        self.courseNumber.isSecureTextEntry = false
        self.courseNumber.autocapitalizationType = .none
        self.courseNumber.autocorrectionType = .no
        self.courseNumber.borderStyle = .none
        
        // Rating Field
        self.rating.attributedPlaceholder = NSAttributedString(string: "Rating (1-5)",
                                                               attributes: [.font : UIFont(name: "Futura", size: 20)!])
        self.rating.font = futura
        self.rating.backgroundColor = UIColor(red:0.89, green:0.60, blue:0.60, alpha:1.0)
        self.rating.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
        self.rating.autocapitalizationType = .none
        self.rating.autocorrectionType = .no
        self.rating.borderStyle = .none
        
        let submitBtnTitle = NSAttributedString(string: "Submit", attributes: [.font : UIFont(name: "Futura", size: 20)!])
        self.submitBtn.backgroundColor = UIColor(red:0.89, green:0.60, blue:0.60, alpha:1.0)
        self.submitBtn.setAttributedTitle(submitBtnTitle, for: .normal)
        self.submitBtn.clipsToBounds = true
        self.submitBtn.addTarget(self, action: #selector(submitBtnPressed(sender:)), for: .touchUpInside)

        self.dismissBtn.setImage(UIImage(named: "cancel"), for: .normal)
        self.dismissBtn.addTarget(self, action: #selector(dismissBtnPressed(sender :)), for: .touchUpInside)
    }
    
    func activateConstraints() {
        
        let headerConstraint = [self.header.topAnchor.constraint(equalTo: self.view.topAnchor, constant : 160),
                                self.header.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                self.header.widthAnchor.constraint(equalToConstant: 250),
                                self.header.heightAnchor.constraint(equalToConstant: 30)]
        
        let courseNameConstraint = [self.courseNumber.widthAnchor.constraint(equalToConstant: 360),
                               self.courseNumber.heightAnchor.constraint(equalToConstant: 50),
                               self.courseNumber.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
                               self.courseNumber.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 240)]
        
        let courseNumberConstraint = [self.courseName.widthAnchor.constraint(equalToConstant: 360),
                                  self.courseName.heightAnchor.constraint(equalToConstant: 50),
                                  self.courseName.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
                                  self.courseName.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 310)]
        
        let ratingConstraint = [self.rating.widthAnchor.constraint(equalToConstant: 360),
                               self.rating.heightAnchor.constraint(equalToConstant: 50),
                               self.rating.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
                               self.rating.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 380)]
        
        let BtnConstraint = [self.submitBtn.widthAnchor.constraint(equalToConstant: 300),
                                   self.submitBtn.heightAnchor.constraint(equalToConstant: 40),
                                   self.submitBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                   self.submitBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 510),
                                   
                                   self.dismissBtn.widthAnchor.constraint(equalToConstant: 30),
                                   self.dismissBtn.heightAnchor.constraint(equalToConstant: 30),
                                   self.dismissBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                                   self.dismissBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 45)]
        
        NSLayoutConstraint.activate(headerConstraint)
        NSLayoutConstraint.activate(courseNameConstraint)
        NSLayoutConstraint.activate(courseNumberConstraint)
        NSLayoutConstraint.activate(ratingConstraint)
        NSLayoutConstraint.activate(BtnConstraint)
    }
    
    /* ------------------------------------------------------------------------------------------------------------------------------ */
    
    /* Read input fields, create a new course, for this course for the current user */
    @objc func submitBtnPressed(sender: UIButton) {
        
        if isInputValid() {
            // Create new course and rating
            print("add new course")
            let inputCourseName = self.courseName.text!
            let inputCourseNumber = self.courseNumber.text!.replacingOccurrences(of: " ", with: "")
            let inputRating = Double(self.rating.text!)!

            let courseID = DataBase.instance.REF_COURSES.childByAutoId().key!

            DataBase.instance.createCourse(courseID : courseID, metadata: ["courseName":inputCourseName, "courseNumber":inputCourseNumber,"rating": inputRating, "ratingCount" : 1]) {
                
                (success) in
                /* A course with the same name (e.g. CS300) already existed */
                if !success {

                    let alertController = UIAlertController(title: "Alert", message: "Course already exist", preferredStyle: .alert)
                    
                    let a = UIAlertAction(title: "Dismiss", style: .destructive) { (action:UIAlertAction) in
                        print("You've pressed the destructive");
                    }
                    
                    alertController.addAction(a)
                    self.present(alertController, animated: true, completion: nil)
                }
                else {
                    
                    DataBase.instance.saveCourseToUser(uid: Auth.auth().currentUser!.uid, courseID: courseID, completion: {
                        (success) in
                        self.dismiss(animated: true, completion: nil)
                    })
                }
            }
        }
        /* Input fields are not all filled in */
        else {
            let alertController = UIAlertController(title: "Alert", message: "Please fill in all fields", preferredStyle: .alert)
            
            let a = UIAlertAction(title: "Dismiss", style: .destructive) { (action:UIAlertAction) in
                print("You've pressed the destructive");
            }
            
            alertController.addAction(a)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    /* Dismiss this field */
    @objc func dismissBtnPressed(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /* Check if input fields are not empty and rating is within legal range */
    func isInputValid() -> Bool{
        if self.courseName.text == nil || self.courseNumber.text == nil || self.rating.text == nil {
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
