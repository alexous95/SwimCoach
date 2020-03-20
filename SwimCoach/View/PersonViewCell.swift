//
//  PersonViewCell.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 19/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit

class PersonViewCell: UITableViewCell {

    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var isPresentSwitch: UISwitch!
    
    let gradient = CAGradientLayer()
    
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        switch traitCollection.userInterfaceStyle {
        case .dark:
            isPresentSwitch.onTintColor = UIColor(named: "SwitchDark")
        default:
            isPresentSwitch.onTintColor = .systemBlue
        }
    }
        
    // This method is used to apply a gradient to our custom cells
    
    func configure(lastName: String, firstName: String) {
        lastNameLabel.text = lastName
        firstNameLabel.text = firstName
        isPresentSwitch.isOn = false
    }
   
}
