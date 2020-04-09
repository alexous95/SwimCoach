//
//  WorkoutTitleCell.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 03/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit
import Combine

class WorkoutTitleCell: UITableViewCell {

    
    @IBOutlet weak var title: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        title.delegate = self
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        title.layer.cornerRadius = 10
        title.layer.borderColor = UIColor.white.cgColor
        title.layer.borderWidth = 1
        title.layer.masksToBounds = true
    }
    
    func configure(newTitle: String) {
        title.text = newTitle
    }
    
}

extension WorkoutTitleCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        title.resignFirstResponder()
        return true
    }
    
}
