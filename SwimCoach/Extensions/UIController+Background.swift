//
//  UIController+Background.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 01/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// Setsup background gradient for the controller
    ///
    /// - Parameter gradient: A CAGradientLayer object that is used to apply our gradients
    ///
    /// The gradient is updated every time the view will appear to update its frame and make it equal to the view's bound
    func setupBackground(gradient: CAGradientLayer) {
        guard let backStartColor = UIColor(named: "BackgroundStart")?.resolvedColor(with: self.traitCollection) else {
            print("on a pas la couleur")
            return }
        guard let backEndColor = UIColor(named: "BackgroundEnd")?.resolvedColor(with: self.traitCollection) else { return }
        
        gradient.colors = [backStartColor.cgColor, backEndColor.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }
}
