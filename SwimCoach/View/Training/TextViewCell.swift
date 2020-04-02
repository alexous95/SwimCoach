//
//  TextViewCell.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 26/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit

class TextViewCell: UITableViewCell {

    @IBOutlet weak var trainingText: UITextView!
    
    func configure(text: String) {
        print("on a configurer le text")
        trainingText.text = text
    }

}
