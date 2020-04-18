//
//  DetailWorkoutController.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 26/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit
import Combine

class DetailWorkoutController: UIViewController {

    // MARK: - Outlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    
    /// The gradient object we use to apply our gradient colors
    let gradient = CAGradientLayer()
    
    /// The workout choosen by the user
    var workout: Workout?
    
    /// The group choosen by the user
    var group: Group?
    
    /// The month choosen by the user
    var month: String?
    
    /// The viewModel that manage the data for our controller
    var viewModel: DetailWorkoutViewModel?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupBackground(gradient: gradient)
        setupDelegate()
    }

    override func viewDidLayoutSubviews() {
        gradient.frame = view.bounds
        setupBackground(gradient: gradient)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editWorkoutSegue" {
            guard let workout = workout else { return }
            
            let destVC: AddWorkoutLineController = segue.destination as! AddWorkoutLineController
            destVC.viewModel.workoutLines = workout.workoutLines
            destVC.viewModel.title = workout.title
            destVC.group = group
            destVC.month = month
            destVC.viewModel.workout = workout
        }
    }
    
    // MARK: - Setup
    
    /// Setsup the delegate
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    /// Setsup the view model
    private func setupViewModel() {
        guard let workout = workout else { return }
        viewModel = DetailWorkoutViewModel(workout: workout)
    }

}

// MARK: - Table View Extension

extension DetailWorkoutController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return "% by zone"
        case 2:
            return "% by motricity"
        case 3:
            return "% by stroke"
        case 4:
            return "% by exercice"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 7
        case 2, 3:
            return 3
        case 4:
            return 4
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let workout = workout else { return UITableViewCell() }
        guard let viewModel = viewModel else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "textViewCell", for: indexPath) as? TextViewCell else { return UITableViewCell() }

            cell.configure(text: viewModel.getWorkoutText())
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "zoneCell", for: indexPath)
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Z1: " + String(workout.getDistanceZ1()) + "m"
                cell.detailTextLabel?.text = viewModel.getPercentageZ1() + "%"
            case 1:
                cell.textLabel?.text = "Z2: " + String(workout.getDistanceZ2()) + "m"
                cell.detailTextLabel?.text = viewModel.getPercentageZ2() + "%"
            case 2:
                cell.textLabel?.text = "Z3: " + String(workout.getDistanceZ3()) + "m"
                cell.detailTextLabel?.text = viewModel.getPercentageZ3() + "%"
            case 3:
                cell.textLabel?.text = "Z4: " + String(workout.getDistanceZ4()) + "m"
                cell.detailTextLabel?.text = viewModel.getPercentageZ4() + "%"
            case 4:
                cell.textLabel?.text = "Z5: " + String(workout.getDistanceZ5()) + "m"
                cell.detailTextLabel?.text = viewModel.getPercentageZ5() + "%"
            case 5:
                cell.textLabel?.text = "Z6: " + String(workout.getDistanceZ6()) + "m"
                cell.detailTextLabel?.text = viewModel.getPercentageZ6() + "%"
            case 6:
                cell.textLabel?.text = "Z7: " + String(workout.getDistanceZ7()) + "m"
                cell.detailTextLabel?.text = viewModel.getPercentageZ7() + "%"
            default:
                cell.textLabel!.text = "fail"
            }
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "zoneCell", for: indexPath)
            
            switch indexPath.row {
                
            case 0:
                cell.textLabel?.text = "AmpM: " + String(workout.getDistanceAmpM()) + "m"
                cell.detailTextLabel?.text = viewModel.getPercentageAmpM() + "%"
            case 1:
                cell.textLabel?.text = "CoorM: " + String(workout.getDistanceCoorM()) + "m"
                cell.detailTextLabel?.text = viewModel.getPercentageCoorM() + "%"
            case 2:
                cell.textLabel?.text = "EndM: " + String(workout.getDistanceEndM()) + "m"
                cell.detailTextLabel?.text = viewModel.getPercentageEndM() + "%"
                
            default :
                cell.textLabel?.text = "fail"
                cell.detailTextLabel?.text = "fail2"
            }
            return cell
            
        case 3:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "zoneCell", for: indexPath)
            
            switch indexPath.row {
                
            case 0:
                cell.textLabel?.text = "Crawl: " + String(workout.getDistanceCrawl()) + "m"
                cell.detailTextLabel?.text = viewModel.getPercentageCrawl() + "%"
                
            case 1:
                cell.textLabel?.text = "Medley: " + String(workout.getDistanceMedley()) + "m"
                cell.detailTextLabel?.text = viewModel.getPercentageMedley() + "%"
                
            case 2:
                cell.textLabel?.text = "Spe: " + String(workout.getDistanceSpe()) + "m"
                cell.detailTextLabel?.text = viewModel.getPercentageSpe() + "%"
            default:
                cell.textLabel?.text = "fail"
                cell.detailTextLabel?.text = "fail2"
            }
            
            return cell
            
        case 4:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "zoneCell", for: indexPath)
            
            switch indexPath.row {
                
            case 0:
                cell.textLabel?.text = "NageC: " + String(workout.getDistanceNageC()) + "m"
                cell.detailTextLabel?.text = viewModel.getPercentageNageC() + "%"
                
            case 1:
                cell.textLabel?.text = "Educ: " + String(workout.getDistanceEduc()) + "m"
                cell.detailTextLabel?.text = viewModel.getPercentageEduc() + "%"
                
            case 2:
                cell.textLabel?.text = "Jbs: " + String(workout.getDistanceJbs()) + "m"
                cell.detailTextLabel?.text = viewModel.getPercentageJbs() + "%"
                
            case 3:
                cell.textLabel?.text = "Bras: " + String(workout.getDistanceBras()) + "m"
                cell.detailTextLabel?.text = viewModel.getPercentageBras() + "%"
                
            default:
                cell.textLabel?.text = "fail"
                cell.detailTextLabel?.text = "fail2"
            }
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    
}
