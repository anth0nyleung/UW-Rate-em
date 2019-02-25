//
//  MyAssignmentVC.swift
//  UW-rate_em
//
//  Created by Anthony Leung on 2/18/19.
//  Copyright © 2019 Anthony Leung. All rights reserved.
//

import UIKit
import FirebaseAuth

class MyAssignmentVC: UINavigationController {
    
    var myassignment = [Assignment]()
    
    var logoutBtn : UIButton! = UIButton()
    var header : UILabel! = UILabel()
    var myAssignmentList : UITableView! = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red:1.00, green:0.80, blue:0.80, alpha:1.0)
        self.getMyAssignments()
        self.setupComponent()
        self.activateConstraints()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getMyAssignments()
        self.myAssignmentList.reloadData()
    }
    
    func setupComponent() {
        self.view.addSubview(self.logoutBtn)
        self.view.addSubview(self.header)
        self.view.addSubview(self.myAssignmentList)
        
        self.logoutBtn.translatesAutoresizingMaskIntoConstraints = false
        self.header.translatesAutoresizingMaskIntoConstraints = false
        self.myAssignmentList.translatesAutoresizingMaskIntoConstraints = false
        
        // Logout Button
        self.logoutBtn.setImage(UIImage(named: "logout"), for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.logoutBtn)
        self.logoutBtn.addTarget(self, action: #selector(logoutBtnPressed(sender:)), for: .touchUpInside)
        
        // Header
        self.header.attributedText = NSAttributedString(string: "My Assignment", attributes: [.font : UIFont(name: "Futura", size: 30)!])
        self.header.textAlignment = .center
        self.navigationItem.titleView = header
        
        // Assignment List
        self.myAssignmentList.register(AssignmentCell.self, forCellReuseIdentifier: "assignmentCell")
        self.myAssignmentList.delegate = self
        self.myAssignmentList.dataSource = self
        self.myAssignmentList.backgroundColor = UIColor(red:1.00, green:0.80, blue:0.80, alpha:1.0)
        self.myAssignmentList.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 20)
        self.myAssignmentList.separatorInsetReference = .fromAutomaticInsets
        self.myAssignmentList.rowHeight = 70
        self.myAssignmentList.estimatedRowHeight = 100
        
    }
    
    func activateConstraints() {
        
        let headerConstraint = [self.header.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                self.header.topAnchor.constraint(equalTo: self.navigationBar.topAnchor, constant: 0)]
        
        let btnConstraint = [self.logoutBtn.topAnchor.constraint(equalTo: self.navigationBar.topAnchor, constant: 10),
                             self.logoutBtn.trailingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.view.bounds.width-10),
                             self.logoutBtn.widthAnchor.constraint(equalToConstant: 25),
                             self.logoutBtn.heightAnchor.constraint(equalToConstant: 25)]
        
        let tableConstraint = [self.myAssignmentList.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                               self.myAssignmentList.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                               self.myAssignmentList.topAnchor.constraint(equalTo: self.navigationBar.bottomAnchor),
                               self.myAssignmentList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)]
        
        NSLayoutConstraint.activate(headerConstraint)
        NSLayoutConstraint.activate(btnConstraint)
        NSLayoutConstraint.activate(tableConstraint)
        
    }
    
    func getMyAssignments() {
        DataBase.instance.getUserAssignments(uid: Auth.auth().currentUser!.uid) {
            (res) in
            self.myassignment = res
            self.myassignment.sort(by: { (a, b) -> Bool in
                a.assignmentName < b.assignmentName
            })
            self.myAssignmentList.reloadData()
        }
    }
    
    @objc func logoutBtnPressed(sender: UIButton) {
        print("log out pressed")
        Authenticate.instance.logoutUser()
        present(LoginVC(), animated: true, completion: nil)
    }
}

extension MyAssignmentVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myassignment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.myAssignmentList.dequeueReusableCell(withIdentifier: "assignmentCell", for: indexPath) as! AssignmentCell
        cell.configure(assignment: self.myassignment[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AssignmentVC()
        vc.assignment = self.myassignment[indexPath.row]
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true, completion: nil)
    }

}
