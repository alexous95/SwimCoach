//
//  FolderCollectionViewCell.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 05/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit

class FolderCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlet
    
    @IBOutlet weak var folderImage: UIImageView!
    @IBOutlet weak var groupeName: UILabel!
 
    // MARK: - Configuration
    
    let gradient = CAGradientLayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = contentView.bounds
        setupBackground()
    }
    
    func setCellShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 1.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 3
        self.clipsToBounds = false
    }
    
    func roundCorner() {
        self.contentView.layer.cornerRadius = 12.0
        self.contentView.layer.masksToBounds = true
        self.contentView.clipsToBounds = true
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
    }
    
    fileprivate func setupCell() {
        roundCorner()
        setupBackground()
        setCellShadow()
    }
    
    private func setupBackground() {
        guard let backStartColor = UIColor(named: "FolderCellStart")?.resolvedColor(with: self.traitCollection) else { return }
        guard let backEndColor = UIColor(named: "FolderCellEnd")?.resolvedColor(with: self.traitCollection) else { return }
        
        gradient.colors = [backStartColor.cgColor, backEndColor.cgColor]
        contentView.layer.insertSublayer(gradient, at: 0)
    }
    
    func configure(name: String) {
        groupeName.text = name
    }
}
