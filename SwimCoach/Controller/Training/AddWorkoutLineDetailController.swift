//
//  AddWorkoutLineDetailController.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 01/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit
import Combine

class AddWorkoutLineDetailController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    
    let gradient = CAGradientLayer()
    
    var delegate: TransfertDataProtocol?
    var viewModel = AddWorkoutLineDetailViewModel()
    
    var tmp = ""
    
    // MARK: - Subscribers variables
    
    @Published var workoutText: String = ""
    @Published var workoutLineTitle: String = ""
    
    var workoutSubscriber: AnyCancellable?
    var workoutTitleSubscriber: AnyCancellable?
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupWorkoutTextSubscriber()
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
    
    // MARK: - Subscriber
    
    private func setupWorkoutTextSubscriber() {
        workoutSubscriber = $workoutText.receive(on: DispatchQueue.main).sink(receiveValue: { (text) in
            self.viewModel.updateWorkoutText(text: text)
        })
    }
    
    private func setupWorkoutTitleSubscriber() {
        workoutTitleSubscriber = $workoutLineTitle.receive(on: DispatchQueue.main).sink(receiveValue: { (text) in
            self.viewModel.updateWorkoutTitle(text: text)
        })
    }
    
    
    // MARK: - Action
    
    @IBAction func setDistance(_ sender: UIButton) {
        
        // This two lines are used to avoid duplicated code in the methode
        // We return a function from our viewModel and then use it to update the model inside the viewModel
        
        var function: (Double) -> ()
        function = viewModel.chooseFunc(from: sender.tag)
        
        let alert = UIAlertController(title: "Distance", message: "Add your distance", preferredStyle: .alert)
        
        alert.addTextField { (textfield) in
            textfield.placeholder = "Distance ?"
        }
        
        let save = UIAlertAction(title: "Add", style: .default) { (alertAction) in
            let distanceTextfield = alert.textFields![0] as UITextField
            
            guard let distance = distanceTextfield.text else { return }
            sender.setTitle(distance + " m", for: .normal)
            
            guard let doubleDistance = Double(distance) else {
                return
            }
            
            function(doubleDistance)
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .destructive, handler: nil)
        
        alert.addAction(save)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    @IBAction func saveWorkoutLine(_ sender: Any) {
        
        let alert = UIAlertController(title: "Saving", message: "Do you want to save now ?", preferredStyle: .alert)
        
        let save = UIAlertAction(title: "Save", style: .default) { (_) in
            self.delegate?.getData(data: self.viewModel.workoutLine)
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(save)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    // We use this action to update our model when the user enter a new title in the uitextfields
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        if let text = sender.text {
            workoutLineTitle = text
            print(text)
        }
    }
    
}


// MARK: - Extension

extension AddWorkoutLineDetailController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Workout Title"
        case 1:
            return "Workout text"
        case 2:
            return "Distance by zone"
        case 3:
            return "Distance by motricity"
        case 4:
            return "Distance by stroke"
        case 5:
            return "Distance by exercice"
        default:
            return nil
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 7
        case 3:
            return 3
        case 4:
            return 3
        case 5:
            return 4
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutTitleCell", for: indexPath) as? WorkoutTitleCell else {
                return UITableViewCell()
            }
            
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutTextCell", for: indexPath) as? TextViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(text: viewModel.workoutLine.text)
            
            cell.textChanged =  { [weak tableView] (newText: String) in
                self.workoutText = newText
                DispatchQueue.main.async {
                    tableView?.beginUpdates()
                    tableView?.endUpdates()
                }
            }
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutDetailsCell", for: indexPath) as? ZoneCell else {
                return UITableViewCell()
            }
            
            switch indexPath.row {
            case 0:
                cell.configure(quantif: "Z1 :", dist: String(format: "%.0f" , viewModel.workoutLine.getZ1()))
                cell.distance.tag = 1
            case 1:
                cell.configure(quantif: "Z2 :", dist: String(format: "%.0f", viewModel.workoutLine.getZ2()))
                cell.distance.tag = 2
            case 2:
                cell.configure(quantif: "Z3 :", dist: String(format: "%.0f", viewModel.workoutLine.getZ3()))
                cell.distance.tag = 3
            case 3:
                cell.configure(quantif: "Z4 :", dist: String(format: "%.0f", viewModel.workoutLine.getZ4()))
                cell.distance.tag = 4
            case 4:
                cell.configure(quantif: "Z5 :", dist: String(format: "%.0f", viewModel.workoutLine.getZ5()))
                cell.distance.tag = 5
            case 5:
                cell.configure(quantif: "Z6 :", dist: String(format: "%.0f", viewModel.workoutLine.getZ6()))
                cell.distance.tag = 6
            case 6:
                cell.configure(quantif: "Z7 :", dist: String(format: "%.0f", viewModel.workoutLine.getZ7()))
                cell.distance.tag = 7
            default:
                cell.configure(quantif: "fail", dist: "fail")
            }
            
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutDetailsCell", for: indexPath) as? ZoneCell else {
                return UITableViewCell()
            }
            
            switch indexPath.row {
            case 0:
                cell.configure(quantif: "AmpM :", dist: String(format: "%.0f", viewModel.workoutLine.getAmpM()))
                cell.distance.tag = 10
            case 1:
                cell.configure(quantif: "CoorM", dist: String(format: "%.0f", viewModel.workoutLine.getCoorM()))
                cell.distance.tag = 11
            case 2:
                cell.configure(quantif: "EndM", dist: String(format: "%.0f", viewModel.workoutLine.getEndM()))
                cell.distance.tag = 12
            default:
                cell.configure(quantif: "fail", dist: "fail")
            }
            
            return cell
            
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutDetailsCell", for: indexPath) as? ZoneCell else {
                return UITableViewCell()
            }
            
            switch indexPath.row {
            case 0:
                cell.configure(quantif: "Crawl", dist: String(format: "%.0f", viewModel.workoutLine.getCrawl()))
                cell.distance.tag = 20
            case 1:
                cell.configure(quantif: "Medley", dist: String(format: "%.0f", viewModel.workoutLine.getMedley()))
                cell.distance.tag = 21
            case 2:
                cell.configure(quantif: "Spe", dist: String(format: "%.0f", viewModel.workoutLine.getSpe()))
                cell.distance.tag = 22
            default:
                cell.configure(quantif: "fail", dist: "fail")
            }
            return cell
            
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutDetailsCell", for: indexPath) as? ZoneCell else {
                return UITableViewCell()
            }
            
            switch indexPath.row {
            case 0:
                cell.configure(quantif: "NageC", dist: String(format: "%.0f", viewModel.workoutLine.getNageC()))
                cell.distance.tag = 30
            case 1:
                cell.configure(quantif: "Educ", dist: String(format: "%.0f", viewModel.workoutLine.getEduc()))
                cell.distance.tag = 31
            case 2:
                cell.configure(quantif: "Jbs", dist: String(format: "%.0f", viewModel.workoutLine.getJbs()))
                cell.distance.tag = 32
            case 3:
                cell.configure(quantif: "bras", dist: String(format: "%.0f", viewModel.workoutLine.getBras()))
                cell.distance.tag = 33
            default:
                cell.configure(quantif: "fail", dist: "fail")
            }
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}
