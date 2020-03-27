//
//  DetailWorkoutController.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 26/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit

class DetailWorkoutController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let gradient = CAGradientLayer()
    var workout: Workout?
    
    var viewModel: DetailWorkoutViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupBackground()
        setupDelegate()
        
    }

    override func viewDidLayoutSubviews() {
        gradient.frame = view.bounds
        setupBackground()
    }
    
    // MARK: - UI Setup
    
    /// Setsup the background with a gradient
    private func setupBackground() {
        guard let backStartColor = UIColor(named: "BackgroundStart")?.resolvedColor(with: self.traitCollection) else { return }
        guard let backEndColor = UIColor(named: "BackgroundEnd")?.resolvedColor(with: self.traitCollection) else { return }
        
        gradient.colors = [backStartColor.cgColor, backEndColor.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    // MARK: - Setup
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupViewModel() {
        guard let workout = workout else { return }
        viewModel = DetailWorkoutViewModel(workout: workout)
    }

}

extension DetailWorkoutController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 7
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let workout = workout else {
            print("ca a pas marche")
            return UITableViewCell() }
        
        guard let viewModel = viewModel else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "textViewCell", for: indexPath) as? TextViewCell else { return UITableViewCell() }
            

            // A ajouter au futur view model
            let fullWorkout = workout.description().joined(separator: "\n \n")
            let correctWorkout = fullWorkout.replacingOccurrences(of: "\\n", with: "\n")
            
            cell.configure(text: correctWorkout)
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "zoneCell", for: indexPath)
            
            switch indexPath.row {
            case 0:
                cell.textLabel!.text = "Z1: " + String(workout.getDistanceZ1()) + "m"
                cell.detailTextLabel!.text = viewModel.getPercentageZ1() + "%"
            case 1:
                cell.textLabel!.text = "Z2: " + String(workout.getDistanceZ2()) + "m"
                cell.detailTextLabel!.text = viewModel.getPercentageZ2() + "%"
            case 2:
                cell.textLabel!.text = "Z3: " + String(workout.getDistanceZ3()) + "m"
                cell.detailTextLabel!.text = viewModel.getPercentageZ3() + "%"
            case 3:
                cell.textLabel!.text = "Z4: " + String(workout.getDistanceZ4()) + "m"
                cell.detailTextLabel!.text = viewModel.getPercentageZ4() + "%"
            case 4:
                cell.textLabel!.text = "Z5: " + String(workout.getDistanceZ5()) + "m"
                cell.detailTextLabel!.text = viewModel.getPercentageZ5() + "%"
            case 5:
                cell.textLabel!.text = "Z6: " + String(workout.getDistanceZ6()) + "m"
                cell.detailTextLabel!.text = viewModel.getPercentageZ6() + "%"
            case 6:
                cell.textLabel!.text = "Z7: " + String(workout.getDistanceZ7()) + "m"
                cell.detailTextLabel!.text = viewModel.getPercentageZ7() + "%"
            default:
                cell.textLabel!.text = "fail"
            }
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}
