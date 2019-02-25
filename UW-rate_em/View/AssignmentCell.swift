//
//  AssignmentCell.swift
//  UW-rate_em
//
//  Created by Anthony Leung on 2/21/19.
//  Copyright © 2019 Anthony Leung. All rights reserved.
//

import UIKit

class AssignmentCell: UITableViewCell {

    var assignmentName: UILabel! = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(red:1.00, green:0.80, blue:0.80, alpha:1.0)

        self.setupComponents()
        self.activateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        self.addSubview(self.assignmentName)
        
        self.assignmentName.translatesAutoresizingMaskIntoConstraints = false
        
        self.assignmentName.font = UIFont(name: "Futura", size: 25)
        self.assignmentName.text = ""
        self.assignmentName.textAlignment = .center
        
    }
    
    func activateConstraints() {
        let constraints = [self.assignmentName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                           self.assignmentName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                           self.assignmentName.widthAnchor.constraint(equalToConstant: 250),
                           self.assignmentName.heightAnchor.constraint(equalToConstant: 70)]
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(assignment : Assignment) {
        self.assignmentName.text = assignment.assignmentName
    }
    
}
