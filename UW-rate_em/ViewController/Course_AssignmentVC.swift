//
//  Course_AssignmentVC.swift
//  UW-rate_em
//
//  Created by Anthony Leung on 2/18/19.
//  Copyright © 2019 Anthony Leung. All rights reserved.
//

import UIKit
import Firebase

class Course_AssignmentVC: UINavigationController {
    // All courses
    var courseBank = [Course]()
    
    // UI Elements
    var searchBar : UITextField! = UITextField()
    var addBtn : UIButton! = UIButton()
    var logoutBtn : UIButton! = UIButton()
    var header : UILabel! = UILabel()
    var courseList : UITableView! = UITableView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red:1.00, green:0.80, blue:0.80, alpha:1.0)
        
        self.getAllCourses()
        self.setupComponent()
        self.activateConstraints()

    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    func setupComponent() {
        self.view.addSubview(self.addBtn)
        self.view.addSubview(self.searchBar)
        self.view.addSubview(self.logoutBtn)
        self.view.addSubview(self.header)
        self.view.addSubview(self.courseList)
        
        self.addBtn.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.logoutBtn.translatesAutoresizingMaskIntoConstraints = false
        self.header.translatesAutoresizingMaskIntoConstraints = false
        self.courseList.translatesAutoresizingMaskIntoConstraints = false
        
        // Add Button
        self.addBtn.setImage(UIImage(named: "add"), for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.addBtn)
        self.addBtn.addTarget(self, action: #selector(addBtnPressed(sender :)), for: .touchUpInside)
        
        // Search Box
        self.searchBar.attributedPlaceholder = NSAttributedString(string: "Search Courses", attributes: [.font : UIFont(name: "Futura", size: 20)!])
        let futura = UIFont.init(name: "Futura", size: 20)!
        self.searchBar.backgroundColor = UIColor(red:1.00, green:0.80, blue:0.80, alpha:1.0)
        self.searchBar.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
        self.searchBar.autocapitalizationType = .none
        self.searchBar.autocorrectionType = .no
        self.searchBar.borderStyle = .none
        self.searchBar.font = futura
        self.searchBar.addTarget(self, action: #selector(startEditingSearchBox), for: .editingChanged)
        
        // Logout Button
        self.logoutBtn.setImage(UIImage(named: "logout"), for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.logoutBtn)
        self.logoutBtn.addTarget(self, action: #selector(logoutBtnPressed(sender:)), for: .touchUpInside)
        
        // Header
        self.header.attributedText = NSAttributedString(string: "Courses", attributes: [.font : UIFont(name: "Futura", size: 30)!])
        self.header.textAlignment = .center
        self.navigationItem.titleView = header
        
        // Course List
        self.courseList.register(CourseCell.self, forCellReuseIdentifier: "courseCell")
        self.courseList.delegate = self
        self.courseList.dataSource = self
        self.courseList.backgroundColor = UIColor(red:1.00, green:0.80, blue:0.80, alpha:1.0)
        self.courseList.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 20)
        self.courseList.separatorInsetReference = .fromAutomaticInsets
        self.courseList.rowHeight = 70
        self.courseList.estimatedRowHeight = 100
        
    }
    
    func activateConstraints() {
        
        let headerConstraint = [self.header.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                self.header.topAnchor.constraint(equalTo: self.navigationBar.topAnchor, constant: 0)]
        
        let searchBarConstraint = [self.searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                  self.searchBar.topAnchor.constraint(equalTo: self.navigationBar.bottomAnchor),
                                  self.searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                  self.searchBar.heightAnchor.constraint(equalToConstant: 50)
                                  ]
        
        let btnConstraint = [self.addBtn.topAnchor.constraint(equalTo: self.navigationBar.topAnchor, constant: 10),
                             self.addBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                             self.addBtn.widthAnchor.constraint(equalToConstant: 25),
                             self.addBtn.heightAnchor.constraint(equalToConstant: 25),
                             
                             self.logoutBtn.topAnchor.constraint(equalTo: self.navigationBar.topAnchor, constant: 10),
                             self.logoutBtn.trailingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.view.bounds.width-10),
                             self.logoutBtn.widthAnchor.constraint(equalToConstant: 25),
                             self.logoutBtn.heightAnchor.constraint(equalToConstant: 25)]
        
        let tableConstraint = [self.courseList.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                               self.courseList.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                               self.courseList.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
                               self.courseList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)]
        
        NSLayoutConstraint.activate(headerConstraint)
        NSLayoutConstraint.activate(searchBarConstraint)
        NSLayoutConstraint.activate(btnConstraint)
        NSLayoutConstraint.activate(tableConstraint)
        
    }

    /* Present AddNewCourseVC is user is authenticated, else show alert */
    @objc func addBtnPressed(sender: UIButton) {
        print("add new VC pressed")
        if Auth.auth().currentUser != nil{
            self.present(AddNewCourseVC(), animated: true, completion: nil)
        }
        else {
            let alertController = UIAlertController(title: "Alert", message: "Visitor cannot add new course", preferredStyle: .alert)
            
            let a = UIAlertAction(title: "Okay", style: .destructive) { (action:UIAlertAction) in
                print("You've pressed the destructive");
            }
            
            alertController.addAction(a)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    /* If user is authenticated, logout user and present LoginVC.
       If user is not authenticated, just present LoginVC
     */
    @objc func logoutBtnPressed(sender: UIButton) {
        print("log out pressed")
        if Auth.auth().currentUser != nil {
            Authenticate.instance.logoutUser()
        }
        present(LoginVC(), animated: true, completion: nil)
    }
    
    /* Search Function */
    @objc func startEditingSearchBox() {
        
        var nameBank = [String : Course]()

        for each in self.courseBank {
            nameBank[each.courseNumber] = each
        }
        
        if self.searchBar.text == "" {
            getAllCourses()
        }
        else {
            var res = [Course]()
            
            for each in nameBank {
                if each.key.lowercased().contains(self.searchBar.text!.lowercased()) {
                    res.append(each.value)
                }
            }
            self.courseBank = res
            self.courseBank.sort(by: { (a, b) -> Bool in
                a.courseNumber < b.courseNumber
            })
            self.courseList.reloadData()
        }
    }
    
    /* Get and Store all exisiting courses */
    func getAllCourses() {
        DataBase.instance.getAllCourses {
            (courses) in
            self.courseBank = courses
            self.courseBank.sort(by: { (a, b) -> Bool in
                a.courseNumber < b.courseNumber
            })
            self.courseList.reloadData()
        }
    }
}


extension Course_AssignmentVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courseBank.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.courseList.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! CourseCell
        
        cell.configure(course: self.courseBank[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let courseVC = CourseVC()
        courseVC.course = self.courseBank[indexPath.row]
        courseVC.modalTransitionStyle = .flipHorizontal
        present(courseVC, animated: true, completion: nil)
    }
    
}

