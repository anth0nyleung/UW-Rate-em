//
//  SignupVC.swift
//  UW-rate_em
//
//  Created by Anthony Leung on 2/18/19.
//  Copyright © 2019 Anthony Leung. All rights reserved.
//

import UIKit
import Firebase

class SignupVC: UIViewController {

    var header : UILabel! = UILabel()
    var displayName : UITextField! = UITextField()
    var email : UITextField! = UITextField()
    var password : UITextField! = UITextField()
    var confirmPassword : UITextField! = UITextField()
    var submitBtn : UIButton! = UIButton()
    var backBtn : UIButton! = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupView()
        
    }
    
    func setupView() {

        self.view.backgroundColor = UIColor(red:0.87, green:0.09, blue:0.09, alpha:1.0)
        
        // Add Subview
        self.view.addSubview(header)
        self.view.addSubview(displayName)
        self.view.addSubview(email)
        self.view.addSubview(password)
        self.view.addSubview(confirmPassword)
        self.view.addSubview(submitBtn)
        self.view.addSubview(backBtn)
        
        // Configure UI Element
        self.configureHeader()
        self.configureTextField()
        self.configureBtn()
        
    }
    
    func configureHeader() {
        
        // Header
        self.header.font = UIFont(name: "Futura", size: 30)
        self.header.text = "Register"
        
        let headerConstraint = [self.header.topAnchor.constraint(equalTo: self.view.topAnchor, constant : 160),
                                self.header.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                self.header.widthAnchor.constraint(equalToConstant: 120),
                                self.header.heightAnchor.constraint(equalToConstant: 70)]
        
        // Translate Autoresizing Mask Into Constraints
        self.header.translatesAutoresizingMaskIntoConstraints = false
        
        // Activate constraints
        NSLayoutConstraint.activate(headerConstraint)
        
    }
    
    
    func configureTextField() {
        // Display Name
        self.displayName.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [.font : UIFont(name: "Futura", size: 20)!])
        self.displayName.backgroundColor = UIColor(red:0.90, green:0.49, blue:0.49, alpha:1.0)
        self.displayName.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
        self.displayName.autocapitalizationType = .none
        self.displayName.autocorrectionType = .no
        self.displayName.borderStyle = .none
        
        let nameConstraint = [self.displayName.widthAnchor.constraint(equalToConstant: 360),
                              self.displayName.heightAnchor.constraint(equalToConstant: 50),
                              self.displayName.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
                              self.displayName.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 240)]
        
        // Email
        self.email.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.font : UIFont(name: "Futura", size: 20)!])
        self.email.backgroundColor = UIColor(red:0.90, green:0.49, blue:0.49, alpha:1.0)
        self.email.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
        self.email.autocapitalizationType = .none
        self.email.autocorrectionType = .no
        self.email.borderStyle = .none
        
        let emailConstraint = [self.email.widthAnchor.constraint(equalToConstant: 360),
                               self.email.heightAnchor.constraint(equalToConstant: 50),
                               self.email.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
                               self.email.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 310)]
        
        // Password
        self.password.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.font : UIFont(name: "Futura", size: 20)!])
        self.password.backgroundColor = UIColor(red:0.90, green:0.49, blue:0.49, alpha:1.0)
        self.password.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
        self.password.autocapitalizationType = .none
        self.password.isSecureTextEntry = true
        self.password.autocorrectionType = .no
        self.password.borderStyle = .none
        let passwordConstraint = [self.password.widthAnchor.constraint(equalToConstant: 360),
                                  self.password.heightAnchor.constraint(equalToConstant: 50),
                                  self.password.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
                                  self.password.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 380)]
        
        // Confirm Password
        self.confirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [.font : UIFont(name: "Futura", size: 20)!])
        self.confirmPassword.backgroundColor = UIColor(red:0.90, green:0.49, blue:0.49, alpha:1.0)
        self.confirmPassword.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
        self.confirmPassword.autocapitalizationType = .none
        self.confirmPassword.isSecureTextEntry = true
        self.confirmPassword.autocorrectionType = .no
        self.confirmPassword.borderStyle = .none
        
        let confirmPasswordConstraint = [self.confirmPassword.widthAnchor.constraint(equalToConstant: 360),
                                         self.confirmPassword.heightAnchor.constraint(equalToConstant: 50),
                                         self.confirmPassword.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
                                         self.confirmPassword.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 450)]
        
        // Translate Autoresizing Mask Into Constraints
        self.displayName.translatesAutoresizingMaskIntoConstraints = false
        self.email.translatesAutoresizingMaskIntoConstraints = false
        self.password.translatesAutoresizingMaskIntoConstraints = false
        self.confirmPassword.translatesAutoresizingMaskIntoConstraints = false
        
        // Activate Constraint
        NSLayoutConstraint.activate(nameConstraint)
        NSLayoutConstraint.activate(emailConstraint)
        NSLayoutConstraint.activate(passwordConstraint)
        NSLayoutConstraint.activate(confirmPasswordConstraint)
        
    }
    
    func configureBtn() {
        
        // Submit Button
        let submitTitle = NSAttributedString(string: "Submit", attributes: [.font : UIFont(name: "Futura", size: 20)!])
        self.submitBtn.backgroundColor = UIColor(red:0.90, green:0.49, blue:0.49, alpha:1.0)
        self.submitBtn.setAttributedTitle(submitTitle, for: .normal)
        self.submitBtn.clipsToBounds = true
        
        
        let submitBtnConstraint = [self.submitBtn.widthAnchor.constraint(equalToConstant: 300),
                                   self.submitBtn.heightAnchor.constraint(equalToConstant: 40),
                                   self.submitBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                   self.submitBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 510)]
        
        // Back Button
        let backTitle = NSAttributedString(string: "Back", attributes: [.font : UIFont(name: "Futura", size: 20)!])
        self.backBtn.backgroundColor = UIColor(red:0.90, green:0.49, blue:0.49, alpha:1.0)
        self.backBtn.setAttributedTitle(backTitle, for: .normal)
        self.backBtn.clipsToBounds = true
        
        
        let backBtnConstraint = [self.backBtn.widthAnchor.constraint(equalToConstant: 300),
                                 self.backBtn.heightAnchor.constraint(equalToConstant: 40),
                                 self.backBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                 self.backBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 560)]
        
        // Translate Autoresizing Mask Into Constraint
        self.submitBtn.translatesAutoresizingMaskIntoConstraints = false
        self.backBtn.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Activate Constraints
        NSLayoutConstraint.activate(backBtnConstraint)
        NSLayoutConstraint.activate(submitBtnConstraint)
        
        // Register Action
        self.submitBtn.addTarget(self, action: #selector(self.submitBtnPressed(sender: )), for: .touchUpInside)
        self.backBtn.addTarget(self, action: #selector(self.backBtnPressed(sender:)), for: .touchUpInside)
    }
    
    
    @objc func submitBtnPressed(sender : UIButton) {
        if isSubmitValid() {
            Authenticate.instance.signupUser(displayName: displayName.text!, email: email.text!, password: password.text!) {
                (success, e) in
                if success {
                    let main = MainVC()
                    main.modalTransitionStyle = .crossDissolve
                    self.present(main, animated: true, completion: nil)
                    print("New user signed up")
                }
                else {
                    let alertController = UIAlertController(title: "Alert", message: "Unable to create new user", preferredStyle: .alert)
                    
                    let a = UIAlertAction(title: "Dismiss", style: .destructive) { (action:UIAlertAction) in
                        print("You've pressed the destructive");
                    }
                    
                    alertController.addAction(a)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        else {
            let alertController = UIAlertController(title: "Alert", message: "Please fill in all fields", preferredStyle: .alert)
            
            let a = UIAlertAction(title: "Dismiss", style: .destructive) { (action:UIAlertAction) in
                print("You've pressed the destructive");
            }
            
            alertController.addAction(a)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func backBtnPressed(sender : UIButton) {
        let loginVC = LoginVC()
        loginVC.modalTransitionStyle = .crossDissolve
        present(loginVC, animated: true, completion: nil)
    }
    
    
    func isSubmitValid()-> Bool {
        if self.displayName.text == nil {
            return false
        }
        if self.email.text == nil {
            return false
        }
        if self.password.text == nil {
            return false
        }
        if self.confirmPassword.text == nil {
            return false
        }
        if self.password.text != confirmPassword.text {
            return false
        }
        return true
    }
}
