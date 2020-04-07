//
//  CustomButton.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 07/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        setupColor()
    }
    
    private func setupColor() {
        guard let backStartColor = UIColor(named: "FolderCellStart")?.resolvedColor(with: self.traitCollection) else { return }
        self.backgroundColor = backStartColor
    }
}
