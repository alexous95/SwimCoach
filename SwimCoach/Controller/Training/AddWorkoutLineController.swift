//
//  AddWorkoutLineController.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 01/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit

class AddWorkoutLineController: UIViewController {

    // MARK: - Outlet
    
    @IBOutlet weak var addLine: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    
    let gradient = CAGradientLayer()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = view.bounds
        setupBackground(gradient: gradient)
    }
    
    // MARK: - UI Setup
    
    private func setupButton() {
        addLine.layer.cornerRadius = 10
        addLine.layer.borderColor = UIColor.white.cgColor
        addLine.layer.borderWidth = 1.0
    }
}

// MARK: - Extensions

extension AddWorkoutLineController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutLineCell", for: indexPath)
        
        cell.textLabel?.text = "test"
        cell.detailTextLabel?.text = "test2"
        
        return cell
    }
    
    
}
