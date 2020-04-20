//
//  TrainingCollectionViewCell.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 25/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit

class TrainingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlet
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleTrain: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    // MARK: - Variables
    
    let gradient = CAGradientLayer()
    
    
    // MARK: - Private
    
    /// Add a gradient layer to our cells
    private func setupBackground() {
        guard let backStartColor = UIColor(named: "FolderCellStart")?.resolvedColor(with: self.traitCollection) else { return }
        guard let backEndColor = UIColor(named: "FolderCellEnd")?.resolvedColor(with: self.traitCollection) else { return }
        
        gradient.colors = [backStartColor.cgColor, backEndColor.cgColor]
        contentView.layer.insertSublayer(gradient, at: 0)
    }
    
    private func setupCorner() {
        contentView.layer.cornerRadius = 10
    }
    
    // MARK: - Configuration
    
    // This methodes is used to apply our gradient and to force our cells to layout again
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = contentView.bounds
        setupBackground()
        setupCorner()
    }
    
    func configure(date: String, titreSeance: String, distance: String) {
        dateLabel.text = date
        titleTrain.text = titreSeance
        distanceLabel.text = distance + "m"
    }
}
