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
    @IBOutlet weak var workoutTitle: UITextField!
    @IBOutlet weak var dateButton: UIButton!
    
    // MARK: - Variables
    
    /// The group choosen by the user
    var group: Group?
    
    /// The month choosen by the user
    var month: String?
    
    /// A toolbar that will be added on top of our keyboard
    var toolBar = UIToolbar()
    
    /// A date picker to choose a date
    var picker = UIDatePicker()
    
    /// The gradient object we use to apply our gradient colors
    let gradient = CAGradientLayer()
    
    /// The viewModel that manage the data for our controller
    let viewModel = AddWorkoutLineViewModel()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupDelegate()
        setupTextfield()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = view.bounds
        setupBackground(gradient: gradient)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailWorkoutLine" {
            let destVC: AddWorkoutLineDetailController = segue.destination as! AddWorkoutLineDetailController
            destVC.delegate = self
            destVC.group = group
            destVC.month = month
            destVC.workout = viewModel.workout
        }
        
        if segue.identifier == "detailWorkoutTableSegue" {
            let destVC: AddWorkoutLineDetailController = segue.destination as! AddWorkoutLineDetailController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let index = indexPath.row
        
            let workoutLine = viewModel.workoutLines[index]
            destVC.viewModel.workoutLine = workoutLine
            destVC.viewModel.workoutText = workoutLine.text
            destVC.viewModel.workoutLineTitle = workoutLine.workoutLineTitle
            destVC.textViewClearedOnEdit = true
            destVC.group = group
            destVC.month = month
            destVC.workout = viewModel.workout
            destVC.delegate = self
        }
    }
    
    // MARK: - Setup
    
    /// Setsup the delegates
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        
        workoutTitle.delegate = self
    }
   
    
    // MARK: - UI Setup
    
    /// Makes the buttons rounded with a white border
    private func setupButton() {
        addLine.layer.cornerRadius = 10
        addLine.layer.borderColor = UIColor.white.cgColor
        addLine.layer.borderWidth = 1.0
        
        dateButton.layer.cornerRadius = 10
        dateButton.layer.borderColor = UIColor.white.cgColor
        dateButton.layer.borderWidth = 1.0
        dateButton.setTitle(viewModel.printDate(), for: .normal)
    }
    
    /// Setsup the textfields border and radius
    private func setupTextfield() {
        if viewModel.title != "" {
            workoutTitle.text = viewModel.title
        }
        
        workoutTitle.layer.cornerRadius = 10
        workoutTitle.layer.borderColor = UIColor.white.cgColor
        workoutTitle.layer.borderWidth = 1.0
        workoutTitle.layer.masksToBounds = true
    }
    
    // MARK: - OBJC Action
    
    /// Add the workoutLines to the workout
    @objc private func addLineToWorkout() {
        guard let group = group else { return }
        guard let month = month else { return }
        
        viewModel.addLineToWorkout(to: group, for: month)
        navigationController?.popViewController(animated: true)
    }
    
    /// Shows a date picker with a toolbar to dismiss
    @IBAction func changeDate(_ sender: Any) {
        picker = UIDatePicker.init()
        tabBarController?.tabBar.isHidden = true
        picker.backgroundColor = .systemBackground
        
        picker.autoresizingMask = .flexibleWidth
        picker.datePickerMode = .date
        
        picker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        picker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        // The toolbar is used to add a "done" button to dismiss the date picker
        
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
        
    }
    
    /// Change the dateButton title according to date selected in the picker
    @objc func dateChanged(_ sender: UIDatePicker?) {
        if let date = sender?.date {
            dateButton.setTitle(viewModel.printDate(from: date), for: .normal)
        }
    }
    
    /// Dismiss the date picker
    @objc func onDoneButtonClick() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Action
    
    /// Creates a workout if the viewModel workout is nil
    @IBAction func addNewLine(sender: Any) {
        if viewModel.workout == nil {
            guard let title = workoutTitle.text else { return }
            guard let date = dateButton.titleLabel?.text else { return }
            guard let group = group else { return }
            guard let month = month else { return }
            viewModel.createWorkout(title: title, date: date, for: group, for: month)
        }
    }
}

// MARK: - Extensions

extension AddWorkoutLineController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfLines()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutLineCell", for: indexPath)
        
        cell.textLabel?.text = viewModel.workoutLines[indexPath.row].workoutLineTitle
        cell.detailTextLabel?.text = String(format: "%.0f", viewModel.workoutLines[indexPath.row].getDistance())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 100))
         newView.backgroundColor = .clear
        
        guard let buttonColor = UIColor(named: "FolderCellEnd")?.resolvedColor(with: self.traitCollection) else {
            return nil }
        
        let button = CustomButton(frame: CGRect(x: 0, y: 0, width: newView.frame.width * 0.35, height: 40))
        button.center = newView.center
        button.backgroundColor = buttonColor
        button.setTitle("Add", for: .normal)
        button.addTarget(self, action: #selector(addLineToWorkout), for: .touchUpInside)
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

extension AddWorkoutLineController: TransfertDataProtocol {
    func getData(data: WorkoutLine) {
        viewModel.addWorkoutLine(data)
        tableView.reloadData()
    }
}


extension AddWorkoutLineController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        viewModel.title = text
        self.view.endEditing(true)
        return true
    }
}
