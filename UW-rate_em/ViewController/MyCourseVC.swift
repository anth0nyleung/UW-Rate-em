//
//  MyCourseVC.swift
//  UW-rate_em
//
//  Created by Anthony Leung on 2/18/19.
//  Copyright © 2019 Anthony Leung. All rights reserved.
//

import UIKit
import FirebaseAuth

class MyCourseVC: UINavigationController {

    var mycourse = [Course]()
    
    var logoutBtn : UIButton! = UIButton()
    var header : UILabel! = UILabel()
    var myCourseList : UITableView! = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red:1.00, green:0.80, blue:0.80, alpha:1.0)
        self.getMyCourses()
        self.setupComponent()
        self.activateConstraints()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getMyCourses()
        self.myCourseList.reloadData()
    }
    
    func setupComponent() {
        self.view.addSubview(self.logoutBtn)
        self.view.addSubview(self.header)
        self.view.addSubview(self.myCourseList)
        
        self.logoutBtn.translatesAutoresizingMaskIntoConstraints = false
        self.header.translatesAutoresizingMaskIntoConstraints = false
        self.myCourseList.translatesAutoresizingMaskIntoConstraints = false
        
        // Logout Button
        self.logoutBtn.setImage(UIImage(named: "logout"), for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.logoutBtn)
        self.logoutBtn.addTarget(self, action: #selector(logoutBtnPressed(sender:)), for: .touchUpInside)
        
        // Header
        self.header.attributedText = NSAttributedString(string: "My Courses", attributes: [.font : UIFont(name: "Futura", size: 30)!])
        self.header.textAlignment = .center
        self.navigationItem.titleView = header
        
        // Course List
        self.myCourseList.register(CourseCell.self, forCellReuseIdentifier: "courseCell")
        self.myCourseList.delegate = self
        self.myCourseList.dataSource = self
        self.myCourseList.backgroundColor = UIColor(red:1.00, green:0.80, blue:0.80, alpha:1.0)
        self.myCourseList.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 20)
        self.myCourseList.separatorInsetReference = .fromAutomaticInsets
        self.myCourseList.rowHeight = 70
        self.myCourseList.estimatedRowHeight = 100
        
    }
    
    func activateConstraints() {
        
        let headerConstraint = [self.header.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                self.header.topAnchor.constraint(equalTo: self.navigationBar.topAnchor, constant: 0)]
        
        let btnConstraint = [self.logoutBtn.topAnchor.constraint(equalTo: self.navigationBar.topAnchor, constant: 10),
                             self.logoutBtn.trailingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.view.bounds.width-10),
                             self.logoutBtn.widthAnchor.constraint(equalToConstant: 25),
                             self.logoutBtn.heightAnchor.constraint(equalToConstant: 25)]
        
        let tableConstraint = [self.myCourseList.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                               self.myCourseList.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                               self.myCourseList.topAnchor.constraint(equalTo: self.navigationBar.bottomAnchor),
                               self.myCourseList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)]
        
        NSLayoutConstraint.activate(headerConstraint)
        NSLayoutConstraint.activate(btnConstraint)
        NSLayoutConstraint.activate(tableConstraint)
        
    }
    
    func getMyCourses() {
        DataBase.instance.getUserCourses(uid: Auth.auth().currentUser!.uid) {
            (res) in
            self.mycourse = res
            self.myCourseList.reloadData()
        }
    }

    
    @objc func logoutBtnPressed(sender: UIButton) {
        print("log out pressed")
        Authenticate.instance.logoutUser()
        present(LoginVC(), animated: true, completion: nil)
    }
}

extension MyCourseVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mycourse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.myCourseList.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! CourseCell
        cell.configure(course: mycourse[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CourseVC()
        vc.course = self.mycourse[indexPath.row]
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true, completion: nil)
    }
}
