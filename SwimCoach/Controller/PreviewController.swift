//
//  PreviewController.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 01/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit

class PreviewController: UIViewController {

    let gradient = CAGradientLayer()
    let newView = UIView()
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        view.frame = imageView.bounds
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = view.bounds
        setupBackground(gradient: gradient)
    }
    
    private func setupImageView() {
        guard let image = UIImage(systemName: "folder") else {
            print("pas d'image")
            return
        }
        
        imageView.image = image
        imageView.tintColor = .white
        imageView.backgroundColor = .clear
        newView.addSubview(imageView)
        view = newView
    }
    
}
