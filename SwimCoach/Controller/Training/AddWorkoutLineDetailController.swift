//
//  AddWorkoutLineDetailController.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 01/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit

class AddWorkoutLineDetailController: UIViewController {

    // MARK: - Outlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    
    let gradient = CAGradientLayer()
    var workoutLine: WorkoutLine?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = view.bounds
        setupBackground(gradient: gradient)
    }

    // MARK: - Private
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension AddWorkoutLineDetailController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 7
        case 2:
            return 4
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutTextCell", for: indexPath) as? TextViewCell else {
            return UITableViewCell()
            }
           
           cell.configure(text: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ")
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutDetailsCell", for: indexPath) as? ZoneCell else {
                return UITableViewCell()
            }
            
            switch indexPath.row {
            case 0:
                cell.configure(quantif: "Z1 : ", dist: "0")
            case 1:
                cell.configure(quantif: "Z2 : ", dist: "0")
            case 2:
                cell.configure(quantif: "Z3 : ", dist: "0")
            case 3:
                cell.configure(quantif: "Z4 : ", dist: "0")
            case 4:
                cell.configure(quantif: "Z5 : ", dist: "0")
            case 5:
                cell.configure(quantif: "Z6 : ", dist: "0")
            case 6:
                cell.configure(quantif: "Z7 : ", dist: "0")
            default:
                cell.configure(quantif: "fail", dist: "fail")
            }
            
            return cell
        default:
            print("On est dans le cas defaut")
           return UITableViewCell()
        }
    }
}
