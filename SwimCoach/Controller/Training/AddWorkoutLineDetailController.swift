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
    
    /// The gradient object we use to apply our gradient colors
    let gradient = CAGradientLayer()
    
    /// The delegate used to transfer data back
    var delegate: TransfertDataProtocol?
    
    /// The viewModel that manage the data for our controller
    var viewModel = AddWorkoutLineDetailViewModel()
    
    /// Indicate if the textView has already been cleared
    var textViewClearedOnEdit = false
    
    /// The group choosen by the user
    var group: Group?
    
    /// The month choosen by the user
    var month: String?
    
    /// The workout choosen by the user
    var workout: Workout?
    
    // MARK: - Subscribers variables
    
    /// The property that will subscribe to the publisher from the view model
    var workoutSubscriber: AnyCancellable?
    
    /// The property that will subscribe to the publisher from the view model
    var workoutTitleSubscriber: AnyCancellable?
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupViewModel()
        setupWorkoutTextSubscriber()
        setupWorkoutTitleSubscriber()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = view.bounds
        setupBackground(gradient: gradient)
    }
    
    // MARK: - Setup
    
    /// Setsup the delegate
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
    }
    
    /// Setsup th viewModel
    private func setupViewModel() {
        viewModel.prepareForDisplay()
    }
    
    
    // MARK: - Subscriber
    
    private func setupWorkoutTextSubscriber() {
        workoutSubscriber = viewModel.$workoutText.receive(on: DispatchQueue.main).sink(receiveValue: { (text) in
            self.viewModel.updateWorkoutText(text: text)
        })
    }
    
    private func setupWorkoutTitleSubscriber() {
        workoutTitleSubscriber = viewModel.$workoutLineTitle.receive(on: DispatchQueue.main).sink(receiveValue: { (text) in
            self.viewModel.updateWorkoutTitle(text: text)
        })
    }
    
    
    // MARK: - Action
    
    /// Change the button's title with the distance choosen by the user
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
            guard let doubleDistance = Double(distance) else { return }
            
            sender.setTitle(distance + " m", for: .normal)
            
            function(doubleDistance)
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .destructive, handler: nil)
        
        alert.addAction(save)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    /// Saves the workout line
    @IBAction func saveWorkoutLine(_ sender: Any) {
        guard let group = group else {
            return
        }
        guard let month = month else {
            return
        }
        guard let workout = workout else {
            return
        }
        let alert = UIAlertController(title: "Saving", message: "Do you want to save now ?", preferredStyle: .alert)
        
        let save = UIAlertAction(title: "Save", style: .default) { (_) in
            self.viewModel.save(for: group, for: month, workout: workout)
            self.delegate?.getData(data: self.viewModel.workoutLine)
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(save)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    /// Updates our model when the user enter a new title in the uitextfields
    @IBAction func textFieldChanged(_ sender: UITextField) {
        if let text = sender.text {
            viewModel.workoutLineTitle = text
        }
    }
    
}


// MARK: - Table View Extension

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
        case 0, 1:
            return 1
        case 2:
            return 7
        case 3, 4:
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
            
            cell.configure(newTitle: viewModel.temporaryWorkoutLine.workoutLineTitle)
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutTextCell", for: indexPath) as? TextViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(text: viewModel.temporaryWorkoutLine.text)
            cell.textViewClearedOnInitialEdit = textViewClearedOnEdit
            
            cell.textChanged =  { [weak tableView] (newText: String) in
                self.viewModel.workoutText = newText
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
                cell.configure(quantif: "Z1 :", dist: String(format: "%.0f" , viewModel.temporaryWorkoutLine.getZ1()))
                cell.distance.tag = indexPath.row + 1
            case 1:
                cell.configure(quantif: "Z2 :", dist: String(format: "%.0f", viewModel.temporaryWorkoutLine.getZ2()))
                cell.distance.tag = indexPath.row + 1
            case 2:
                cell.configure(quantif: "Z3 :", dist: String(format: "%.0f", viewModel.temporaryWorkoutLine.getZ3()))
                cell.distance.tag = indexPath.row + 1
            case 3:
                cell.configure(quantif: "Z4 :", dist: String(format: "%.0f", viewModel.temporaryWorkoutLine.getZ4()))
                cell.distance.tag = indexPath.row + 1
            case 4:
                cell.configure(quantif: "Z5 :", dist: String(format: "%.0f", viewModel.temporaryWorkoutLine.getZ5()))
                cell.distance.tag = indexPath.row + 1
            case 5:
                cell.configure(quantif: "Z6 :", dist: String(format: "%.0f", viewModel.temporaryWorkoutLine.getZ6()))
                cell.distance.tag = indexPath.row + 1
            case 6:
                cell.configure(quantif: "Z7 :", dist: String(format: "%.0f", viewModel.temporaryWorkoutLine.getZ7()))
                cell.distance.tag = indexPath.row + 1
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
                cell.configure(quantif: "AmpM :", dist: String(format: "%.0f", viewModel.temporaryWorkoutLine.getAmpM()))
                cell.distance.tag = indexPath.row + 10
            case 1:
                cell.configure(quantif: "CoorM", dist: String(format: "%.0f", viewModel.temporaryWorkoutLine.getCoorM()))
                cell.distance.tag = indexPath.row + 10
            case 2:
                cell.configure(quantif: "EndM", dist: String(format: "%.0f", viewModel.temporaryWorkoutLine.getEndM()))
                cell.distance.tag = indexPath.row + 10
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
                cell.configure(quantif: "Crawl", dist: String(format: "%.0f", viewModel.temporaryWorkoutLine.getCrawl()))
                cell.distance.tag = indexPath.row + 20
            case 1:
                cell.configure(quantif: "Medley", dist: String(format: "%.0f", viewModel.temporaryWorkoutLine.getMedley()))
                cell.distance.tag = indexPath.row + 20
            case 2:
                cell.configure(quantif: "Spe", dist: String(format: "%.0f", viewModel.temporaryWorkoutLine.getSpe()))
                cell.distance.tag = indexPath.row + 20
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
                cell.configure(quantif: "NageC", dist: String(format: "%.0f", viewModel.temporaryWorkoutLine.getNageC()))
                cell.distance.tag = indexPath.row + 30
            case 1:
                cell.configure(quantif: "Educ", dist: String(format: "%.0f", viewModel.temporaryWorkoutLine.getEduc()))
                cell.distance.tag = indexPath.row + 30
            case 2:
                cell.configure(quantif: "Jbs", dist: String(format: "%.0f", viewModel.temporaryWorkoutLine.getJbs()))
                cell.distance.tag = indexPath.row + 30
            case 3:
                cell.configure(quantif: "bras", dist: String(format: "%.0f", viewModel.temporaryWorkoutLine.getBras()))
                cell.distance.tag = indexPath.row + 30
            default:
                cell.configure(quantif: "fail", dist: "fail")
            }
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}
