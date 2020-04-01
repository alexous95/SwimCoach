//
//  FolderCollectionViewCell.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 05/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit

class FolderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var folderImage: UIImageView!
    @IBOutlet weak var groupeName: UILabel!
    
    let gradient = CAGradientLayer()
  
    func configure(name: String) {
        groupeName.text = name
        contentView.layer.cornerRadius = 10.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = contentView.bounds
        setupBackground()
    }
    
    private func setupBackground() {
        guard let backStartColor = UIColor(named: "BackgroundStart")?.resolvedColor(with: self.traitCollection) else { return }
        guard let backEndColor = UIColor(named: "BackgroundEnd")?.resolvedColor(with: self.traitCollection) else { return }
        
        gradient.colors = [backStartColor.cgColor, backEndColor.cgColor]
        contentView.layer.insertSublayer(gradient, at: 0)
        
    }
    
}
