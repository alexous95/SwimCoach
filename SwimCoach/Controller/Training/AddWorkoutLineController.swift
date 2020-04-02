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
    var group: Group?
    var month: String?
    
    let viewModel = AddWorkoutViewModel()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupDelegate()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = view.bounds
        setupBackground(gradient: gradient)
    }
    
    // MARK: - Setup
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    // MARK: - UI Setup
    
    private func setupButton() {
        addLine.layer.cornerRadius = 10
        addLine.layer.borderColor = UIColor.white.cgColor
        addLine.layer.borderWidth = 1.0
    }
    
    // MARK: - OBJC Action
    
    @objc private func addWorkout() {
        showAlert(withTitle: "test", message: "on test le bouton")
    }
}

// MARK: - Extensions

extension AddWorkoutLineController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfLines()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutLineCell", for: indexPath)
        
        cell.textLabel?.text = "test"
        cell.detailTextLabel?.text = "test2"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 100))
         newView.backgroundColor = .clear
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: newView.frame.width * 0.35, height: 40))
        button.center = newView.center
        button.backgroundColor = .red
        button.setTitle("Add", for: .normal)
        button.addTarget(self, action: #selector(addWorkout), for: .touchUpInside)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        
        newView.addSubview(button)
        
        return newView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    
}
