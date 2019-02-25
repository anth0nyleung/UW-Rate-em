//
//  CommentCell.swift
//  UW-rate_em
//
//  Created by Anthony Leung on 2/20/19.
//  Copyright © 2019 Anthony Leung. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    var comment : UILabel! = UILabel()
    var rating : UILabel! = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(red:1.00, green:0.80, blue:0.80, alpha:1.0)

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
        self.addSubview(self.comment)
        self.addSubview(self.rating)
        
        self.comment.translatesAutoresizingMaskIntoConstraints = false
        self.rating.translatesAutoresizingMaskIntoConstraints = false
        
        self.comment.font = UIFont(name: "Futura", size: 20)
        self.comment.text = ""
        self.comment.textAlignment = .left
        
        self.rating.font = UIFont(name: "Futura", size: 20)
        self.rating.text = ""
        self.rating.textAlignment = .right
    }
    
    func activateConstraints() {
        let constraints = [self.comment.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
                           self.comment.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                           self.comment.widthAnchor.constraint(equalToConstant: 250),
                           self.comment.heightAnchor.constraint(equalToConstant: 50),
                           
                           self.rating.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
                           self.rating.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                           self.rating.widthAnchor.constraint(equalToConstant: 100),
                           self.rating.heightAnchor.constraint(equalToConstant: 50),
                           
                           ]
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(comment : Comment) {
        self.comment.text = comment.content
        self.rating.text = "\(comment.rating!)"
    }
}
