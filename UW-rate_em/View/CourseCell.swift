//
//  CourseCell.swift
//  UW-rate_em
//
//  Created by Anthony Leung on 2/18/19.
//  Copyright © 2019 Anthony Leung. All rights reserved.
//

import UIKit

class CourseCell: UITableViewCell {
    
    var courseName: UILabel! = UILabel()
    var courseNumber: UILabel! = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupComponents()
        self.activateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupComponents() {
        self.addSubview(self.courseNumber)
        self.addSubview(self.courseName)
        
        self.courseNumber.translatesAutoresizingMaskIntoConstraints = false
        self.courseName.translatesAutoresizingMaskIntoConstraints = false
        
        self.courseNumber.font = UIFont(name: "Futura", size: 14)
        self.courseNumber.text = ""
        self.courseNumber.textAlignment = .left
        
        self.courseName.font = UIFont(name: "Futura", size: 20)
        self.courseName.text = ""
        self.courseName.textAlignment = .center
    }
    
    func activateConstraints() {
        let constraints = [self.courseNumber.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
                           self.courseNumber.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                           self.courseNumber.widthAnchor.constraint(equalToConstant: 150),
                           self.courseNumber.heightAnchor.constraint(equalToConstant: 70),
                           
                           self.courseName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                           self.courseName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                           self.courseName.widthAnchor.constraint(equalToConstant: 250),
                           self.courseName.heightAnchor.constraint(equalToConstant: 70),
                           
                           ]
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(course : Course) {
        self.courseName.text = course.courseName
        self.courseNumber.text = course.courseNumber
    }

}
