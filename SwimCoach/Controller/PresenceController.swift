//
//  PresenceController.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 17/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
import UIKit

class PresenceController: UIViewController {
    
    // MARK: - Outlet
    
        
    // MARK: - Variables
    
    var group: Group?
    var viewModel: PresenceViewModel?
    let gradient = CAGradientLayer()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        setupBackground()
        setupNavBar()
        initialiseViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = view.bounds
        setupBackground()
    }
    
    // MARK: - Private
    
    /// Initialise the view model
    ///
    /// We can initialize the view model only after we received the data from the segue transition.
    /// The view model init methode require a group as parameter
    private func initialiseViewModel(){
        guard let group = group else {
            print("Initialisation failed")
            return
        }
        viewModel = PresenceViewModel(group: group)
    }
    
    private func setupBackground() {
        guard let backStartColor = UIColor(named: "BackgroundStart")?.resolvedColor(with: self.traitCollection) else { return }
        guard let backEndColor = UIColor(named: "BackgroundEnd")?.resolvedColor(with: self.traitCollection) else { return }
        
        gradient.colors = [backStartColor.cgColor, backEndColor.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    private func setupNavBar() {
        self.navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: UIColor.white)
    }
    
    
    
}
