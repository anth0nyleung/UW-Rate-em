//
//  ViewController.swift
//  UW-rate_em
//
//  Created by Anthony Leung on 2/13/19.
//  Copyright © 2019 Anthony Leung. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    var header = UILabel()

    var email = UITextField()
    var password = UITextField()
    
    var loginBtn = UIButton()
    var signupBtn = UIButton()
    var guestBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add subview
        self.view.addSubview(self.email)
        self.view.addSubview(self.password)
        self.view.addSubview(self.loginBtn)
        self.view.addSubview(self.signupBtn)
        self.view.addSubview(self.header)
        self.view.addSubview(self.guestBtn)
        self.setUpView()
        
    }
    
    func setUpView() {
        self.view.backgroundColor = UIColor(red:0.87, green:0.09, blue:0.09, alpha:1.0)

        self.setUpHeader()
        self.setUpTextField()
        self.setUpBtn()
        
    }
    
    func setUpHeader() {
        // Header
        self.header.font = UIFont(name: "Futura", size: 30)
        self.header.text = "UW-Rate'em"
        self.header.textAlignment = .center
        
        let headerConstraint = [self.header.topAnchor.constraint(equalTo: self.view.topAnchor, constant : 160),
                                self.header.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                self.header.widthAnchor.constraint(equalToConstant: 250),
                                self.header.heightAnchor.constraint(equalToConstant: 30)]
        
        // Translate Autoresizing Mask Into Constraints
        self.header.translatesAutoresizingMaskIntoConstraints = false
        
        // Activate constraints
        NSLayoutConstraint.activate(headerConstraint)
    }
    
    func setUpTextField() {
        // Email Text Field
        self.email.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.font : UIFont(name: "Futura", size: 20)!])
        self.email.backgroundColor = UIColor(red:0.90, green:0.49, blue:0.49, alpha:1.0)
        self.email.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
        self.email.autocapitalizationType = .none
        self.email.autocorrectionType = .no
        self.email.borderStyle = .none
        
        let emailConstraint = [self.email.widthAnchor.constraint(equalToConstant: 360),
                                    self.email.heightAnchor.constraint(equalToConstant: 50),
                                    self.email.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
                                    self.email.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 240)]
        
        
        
        // Password Text Field
        self.password.attributedPlaceholder = NSAttributedString(string: "Password", attributes : [.font : UIFont(name: "Futura", size: 20)!])
        self.password.backgroundColor = UIColor(red:0.90, green:0.49, blue:0.49, alpha:1.0)
        self.password.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
        self.password.isSecureTextEntry = true
        self.password.autocapitalizationType = .none
        self.password.autocorrectionType = .no
        self.password.borderStyle = .none
        
        let passwordConstraint = [self.password.widthAnchor.constraint(equalToConstant: 360),
                                       self.password.heightAnchor.constraint(equalToConstant: 50),
                                       self.password.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
                                       self.password.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 310)]
        
        // Translate Auto Resizing Make Into Constraints
        self.email.translatesAutoresizingMaskIntoConstraints = false
        self.password.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(emailConstraint)
        NSLayoutConstraint.activate(passwordConstraint)
        
    }
    
    func setUpBtn() {
        // Login Btn
        let loginTitle = NSAttributedString(string: "Login", attributes: [.font : UIFont(name: "Futura", size: 20)!])
        self.loginBtn.backgroundColor = UIColor(red:0.90, green:0.49, blue:0.49, alpha:1.0)
        self.loginBtn.setAttributedTitle(loginTitle, for: .normal)
        self.loginBtn.clipsToBounds = true
        
        
        let loginBtnConstraint = [self.loginBtn.widthAnchor.constraint(equalToConstant: 300),
                                  self.loginBtn.heightAnchor.constraint(equalToConstant: 40),
                                  self.loginBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                  self.loginBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 390)]
        
        
        // Signup Btn
        let signupTitle = NSAttributedString(string: "Sign Up", attributes: [.font : UIFont(name: "Futura", size: 20)!])
        self.signupBtn.backgroundColor = UIColor(red:0.90, green:0.49, blue:0.49, alpha:1.0)
        self.signupBtn.setAttributedTitle(signupTitle, for: .normal)
        self.signupBtn.clipsToBounds = true
        
        let signupBtnConstraint = [self.signupBtn.widthAnchor.constraint(equalToConstant: 300),
                                   self.signupBtn.heightAnchor.constraint(equalToConstant: 40),
                                   self.signupBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                   self.signupBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 440)]
        
        
        // Guest Btn
        let guestTitle = NSAttributedString(string: "Continue as guest", attributes: [.font : UIFont(name: "Futura", size: 20)!])
        self.guestBtn.backgroundColor = UIColor(red:0.90, green:0.49, blue:0.49, alpha:1.0)
        self.guestBtn.setAttributedTitle(guestTitle, for: .normal)
        self.guestBtn.clipsToBounds = true
        
        let guestBtnConstraint = [self.guestBtn.widthAnchor.constraint(equalToConstant: 300),
                                   self.guestBtn.heightAnchor.constraint(equalToConstant: 40),
                                   self.guestBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                   self.guestBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 490)]
        
        // Translate Auto Resizing Make Into Constraints
        self.loginBtn.translatesAutoresizingMaskIntoConstraints = false
        self.signupBtn.translatesAutoresizingMaskIntoConstraints = false
        self.guestBtn.translatesAutoresizingMaskIntoConstraints = false

        // Activate Constraints
        NSLayoutConstraint.activate(loginBtnConstraint)
        NSLayoutConstraint.activate(signupBtnConstraint)
        NSLayoutConstraint.activate(guestBtnConstraint)
        
        self.signupBtn.addTarget(self, action: #selector(signUpBtnPressed(sender:)), for: .touchUpInside)
        self.loginBtn.addTarget(self, action: #selector(loginBtnPressed(sender:)), for: .touchUpInside)
        self.guestBtn.addTarget(self, action: #selector(guestBtnPressed(sender:)), for: .touchUpInside)
    }
    
    @objc func signUpBtnPressed(sender: UIButton) {
        let signupVC = SignupVC()
        signupVC.modalTransitionStyle = .crossDissolve
        present(signupVC, animated: true, completion: nil)
        
    }
    
    @objc func loginBtnPressed(sender: UIButton) {
        print(self.email.text!)
        print(self.password.text!)
        
        if self.email.text != nil && self.password.text != nil {
            Authenticate.instance.loginUser(email: self.email.text!, password: self.password.text!) {
                (success, e) in
                if success {
                    let main = MainVC()
                    main.modalPresentationStyle = .popover
                    self.present(main, animated: true, completion: nil)
                    print("User logged in")
                }
                else {
                    // Alert : Invalid email / Password
                    let alertController = UIAlertController(title: "Alert", message: "Invalid Email or Password", preferredStyle: .alert)
                    
                    let a = UIAlertAction(title: "Dismiss", style: .destructive) { (action:UIAlertAction) in
                        print("You've pressed the destructive");
                    }
                    
                    alertController.addAction(a)
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            }
        }
        else {
            // Alert : Field are empty
            let alertController = UIAlertController(title: "Alert", message: "Please fill in all fields", preferredStyle: .alert)
            
            let a = UIAlertAction(title: "Dismiss", style: .destructive) { (action:UIAlertAction) in
                print("You've pressed the destructive");
            }
            
            alertController.addAction(a)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func guestBtnPressed(sender: UIButton) {
        let destinationVC = Course_AssignmentVC()
        destinationVC.modalTransitionStyle = .crossDissolve
        present(destinationVC, animated: true, completion: nil)
    }
    

}

extension LoginVC: UITextFieldDelegate {}
