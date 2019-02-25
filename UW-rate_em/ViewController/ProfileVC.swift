//
//  ProfileVC.swift
//  UW-rate_em
//
//  Created by Anthony Leung on 2/18/19.
//  Copyright © 2019 Anthony Leung. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileVC: UIViewController {
    
    var nameLabel : UILabel! = UILabel()
    var emailLabel : UILabel! = UILabel()
    var myNameLabel : UILabel! = UILabel()
    var myEmailLabel : UILabel! = UILabel()
    var myCoursesTable : UITableView = UITableView()
    var myAssignmentTable : UITableView = UITableView()
    
    var delegate = UIApplication.shared.delegate as! AppDelegate
    
    
    var name: String! = ""
    var email: String! = ""
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataBase.instance.getUserDisplayName(uid: Auth.auth().currentUser!.uid) { (dispalyName) in
            self.myNameLabel.attributedText = NSAttributedString(string: dispalyName, attributes: [.font : UIFont(name: "Futura", size: 20)!])
        }
            self.myEmailLabel.attributedText = NSAttributedString(string: Auth.auth().currentUser!.email!, attributes: [.font : UIFont(name: "Futura", size: 20)!])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red:1.00, green:0.80, blue:0.80, alpha:1.0)

        self.setupComponent()
        self.activateConstraints()
    }
    
    func setupComponent() {
        
        // Add subview
        self.view.addSubview(self.nameLabel)
        self.view.addSubview(self.emailLabel)
        self.view.addSubview(self.myNameLabel)
        self.view.addSubview(self.myEmailLabel)
        self.view.addSubview(self.myCoursesTable)
        self.view.addSubview(self.myAssignmentTable)

        // Set Translate Auth resizing mask into constraint false
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.emailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.myNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.myEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.myCoursesTable.translatesAutoresizingMaskIntoConstraints = false
        self.myAssignmentTable.translatesAutoresizingMaskIntoConstraints = false
        

        // Set up name and email label
        self.nameLabel.attributedText = NSAttributedString(string: "Name", attributes: [.font : UIFont(name: "Futura", size: 20)!])
        self.nameLabel.textAlignment = .center

        self.emailLabel.attributedText = NSAttributedString(string: "Email", attributes: [.font :UIFont(name: "Futura", size: 20)!])
        self.emailLabel.textAlignment = .center
        
        
        // Set up my name and email label
        
        self.myNameLabel.textAlignment = .center
        self.myEmailLabel.textAlignment = .center

        // Set up tables
        self.myCoursesTable.delegate = self
        self.myCoursesTable.dataSource = self
        self.myCoursesTable.backgroundColor = UIColor(red:0.84, green:0.97, blue:0.93, alpha:1.0)
        self.myCoursesTable.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 20)
        self.myCoursesTable.separatorInsetReference = .fromAutomaticInsets
        self.myCoursesTable.rowHeight = 70
        self.myCoursesTable.estimatedRowHeight = 100

        
        self.myAssignmentTable.delegate = self
        self.myAssignmentTable.dataSource = self
        self.myAssignmentTable.backgroundColor = UIColor(red:0.84, green:0.97, blue:0.93, alpha:1.0)
        self.myAssignmentTable.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 20)
        self.myAssignmentTable.separatorInsetReference = .fromAutomaticInsets
        self.myAssignmentTable.rowHeight = 70
        self.myAssignmentTable.estimatedRowHeight = 100
    
    }
    
    func activateConstraints() {
        let constriants = [self.nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant : 30),
                           self.nameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
                           self.nameLabel.widthAnchor.constraint(equalToConstant: 120),
                           self.nameLabel.heightAnchor.constraint(equalToConstant: 70),
        
                           self.emailLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant : 30),
                           self.emailLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 90),
                           self.emailLabel.widthAnchor.constraint(equalToConstant: 120),
                           self.emailLabel.heightAnchor.constraint(equalToConstant: 70),
                           
                           self.myNameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant : 130),
                           self.myNameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
                           self.myNameLabel.widthAnchor.constraint(equalToConstant: 120),
                           self.myNameLabel.heightAnchor.constraint(equalToConstant: 70),
                           
                           self.myEmailLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant : 130),
                           self.myEmailLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 90),
                           self.myEmailLabel.widthAnchor.constraint(equalToConstant: 200),
                           self.myEmailLabel.heightAnchor.constraint(equalToConstant: 70),
                           
                           
        ]
        
        
        NSLayoutConstraint.activate(constriants)
      
    }
    
}
extension ProfileVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CourseCell
        
        return cell
    }
}

