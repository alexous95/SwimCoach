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
  
    var touchGesture: UITapGestureRecognizer? = nil
    
    func configure(name: String) {
        groupeName.text = name
    }
    
    
    
}
