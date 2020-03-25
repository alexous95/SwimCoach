//
//  TrainingCollectionViewCell.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 25/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit

class TrainingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleTrain: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    let gradient = CAGradientLayer()
    
    private func setupBackground() {
        guard let backStartColor = UIColor(named: "TrainingCellStart")?.resolvedColor(with: self.traitCollection) else { return }
        guard let backEndColor = UIColor(named: "TrainingCellEnd")?.resolvedColor(with: self.traitCollection) else { return }
        
        gradient.colors = [backStartColor.cgColor, backEndColor.cgColor]
        contentView.layer.insertSublayer(gradient, at: 0)
    }
    
    private func setupCorner() {
        contentView.layer.cornerRadius = 10
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = contentView.bounds
        setupBackground()
        setupCorner()
    }
    
    func configure(date: String, titreSeance: String, distance: String) {
        dateLabel.text = date
        titleTrain.text = titreSeance
        distanceLabel.text = distance
    }
}
