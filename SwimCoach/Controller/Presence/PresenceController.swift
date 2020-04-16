//
//  PresenceController.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 17/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
import UIKit
import Combine

class PresenceController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityWheel: UIActivityIndicatorView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var calendarButton: UIButton!
    
    // MARK: - Variables
    
    var group: Group?
    var viewModel: PresenceViewModel?
    
    var toolBar = UIToolbar()
    var picker = UIDatePicker()
    var activitySubscriber: AnyCancellable?
    var availlableDataSubscriber: AnyCancellable?
    
    let gradient = CAGradientLayer()
    let cellSpacingHeight: CGFloat = 20
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        setupNavBar()
        initialiseViewModel()
        setupDelegate()
        createActivitySubscriber()
        createAvaillableDataSubscriber()
        initializeDate()
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = view.bounds
        setupBackground(gradient: gradient)
        
    }
    
    // MARK: - Setup
    
    /// Setsup the table view delegate and data source
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
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
    
    private func initializeDate() {
        guard let viewModel = viewModel else { return }
        
        dateLabel.text = viewModel.printDate()
    }
    
    private func loadData() {
        guard let viewModel = viewModel else { return }
        viewModel.fetchPerson()
    }
        
    // MARK: - UI Setup
    
    /// Add a little image below the nav bar
    private func setupNavBar() {
        self.navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: UIColor.white)
    }
    
    // MARK: - Subscribers
    
    /// Create a subscriber to listen for update from the viewModel if the isLoading value change
    ///
    /// This function uses the Publisher/Subscriber model to update the interface accordingly to the modele.
    /// When the value isLoading change in the view model, the activity wheel start/stop animating accordingly
    private func createActivitySubscriber() {
        guard let viewModel = viewModel else {
            print("pas de view model")
            return
        }
        activitySubscriber = viewModel.$isLoading.receive(on: DispatchQueue.main).sink(receiveValue: { (loading) in
            if loading {
                self.activityWheel.isHidden = !loading
                self.activityWheel.startAnimating()
            } else {
                self.activityWheel.isHidden = !loading
                self.activityWheel.stopAnimating()
            }
        })
    }
    
    /// Create a subscriber to listen for update from the viewModel if the access value change
    ///
    /// This function uses the Publisher/Subscriber model to update the interface accordingly to the modele.
    /// When the value availlable data change in the view model we update our interface
    private func createAvaillableDataSubscriber() {
        guard let viewModel = viewModel else { return }
        
        availlableDataSubscriber = viewModel.$dataAvaillable.receive(on: DispatchQueue.main).sink(receiveValue: { (data) in
            if data {
                self.tableView.reloadData()
            }
        })
    }
    
    // MARK: - Action
    
    /// Adds a person to the database
    @IBAction func addPerson() {
        let alert = UIAlertController(title: "Add group", message: "Choose a name", preferredStyle: .alert)
        
        alert.addTextField { (textfield) in
            textfield.placeholder = "Last name?"
        }
        
        alert.addTextField { (textfield) in
            textfield.placeholder = "First Name?"
        }
        
        let save = UIAlertAction(title: "Add", style: .default) { (alertAction) in
            let lastNameTextField = alert.textFields![0] as UITextField
            let firstNameTextField = alert.textFields![1] as UITextField
            
            guard let lastName = lastNameTextField.text else { return }
            guard let firstName = firstNameTextField.text else { return }
            guard let group = self.group else { return }
            
            if lastName != "" && firstName != "" {
                self.viewModel?.addPerson(lastName: lastName, firstName: firstName, to: group)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(save)
        
        present(alert, animated: true)
    }
    
    
    /// Changes the label date with the date selected
    ///
    /// A date picker is presented to choose the new date
    @IBAction func changeDate(_ sender: Any) {
        picker = UIDatePicker.init()
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
    
    @IBAction func switchChange(_ sender: UISwitch) {
        guard let viewModel = viewModel else { return }
        guard let persons = viewModel.persons else { return }
        guard let group = group else { return }
        
        if sender.isOn {
            let person = persons[sender.tag]
            viewModel.addPresence(personID: person.personID, from: group)
        }
    }
    
    // MARK: - Objc functions
    
    // The next two methodes are used in a selector to display or remove a date picker
    
    /// Update the date label with information from the viewModel
    @objc func dateChanged(_ sender: UIDatePicker?) {
        guard let viewModel = viewModel else { return }
        
        if let date = sender?.date {
            dateLabel.text = viewModel.printDate(from: date)
            tableView.reloadData()
        }
    }
    
    @objc func onDoneButtonClick() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
}

extension PresenceController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 0 }
        guard let persons = viewModel.persons else { return 0 }
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // To access our future array we will have to use indexPath.section rather than row
        
        guard let viewModel = viewModel else { return UITableViewCell() }
        guard let persons = viewModel.persons else { return UITableViewCell() }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as? PersonViewCell else {
            return UITableViewCell()
        }
        
        let person = persons[indexPath.section]
        let active = viewModel.switchState(person: person)
        
        
        cell.configure(lastName: person.lastName, firstName: person.firstName)
        cell.isPresentSwitch.tag = indexPath.section
        cell.isPresentSwitch.isOn = active
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            guard let viewModel = viewModel else { return }
            guard let persons = viewModel.persons else { return }
            guard let group = group else { return }
            
            let person = persons[indexPath.section]
            viewModel.deletePerson(personID: person.personID, from: group)
        }
    }
    
}
