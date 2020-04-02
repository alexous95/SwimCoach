//
//  ZoneCell.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 27/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit

class ZoneCell: UITableViewCell {

    @IBOutlet weak var quantification: UILabel!
    @IBOutlet weak var distance: UIButton!
    
    func configure(quantif: String, dist: String) {
        quantification.text = quantif
        distance.setTitle(dist + "m", for: .normal)
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        
        distance.layer.cornerRadius = 10.0
        distance.layer.borderColor = UIColor.white.cgColor
        distance.layer.borderWidth = 1.0
    }

}
