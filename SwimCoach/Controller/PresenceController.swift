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
    
    // MARK: - Variables
    
    var group: Group?
    var viewModel: PresenceViewModel?
    
    var activitySubscriber: AnyCancellable?
    var availlableDataSubscriber: AnyCancellable?
    
    let gradient = CAGradientLayer()
    let cellSpacingHeight: CGFloat = 20
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        setupBackground()
        setupNavBar()
        initialiseViewModel()
        setupDelegate()
        createActivitySubscriber()
        createAvaillableDataSubscriber()
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = view.bounds
        setupBackground()
        
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
    
    private func loadData() {
        guard let viewModel = viewModel else { return }
        viewModel.fetchPerson()
    }
    
    // MARK: - UI Setup
    
    /// Setsup the background with our custom colors
    private func setupBackground() {
        guard let backStartColor = UIColor(named: "BackgroundStart")?.resolvedColor(with: self.traitCollection) else { return }
        guard let backEndColor = UIColor(named: "BackgroundEnd")?.resolvedColor(with: self.traitCollection) else { return }
        
        gradient.colors = [backStartColor.cgColor, backEndColor.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }
    
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
    /// When the value access change in the view model, we perform a segue if the value is true.
    /// If not, we show an alert with the contextual error
    private func createAvaillableDataSubscriber() {
        guard let viewModel = viewModel else {
            print("pas de view model")
            return
        }
        
        availlableDataSubscriber = viewModel.$dataAvaillable.receive(on: DispatchQueue.main).sink(receiveValue: { (data) in
            if data {
                self.tableView.reloadData()
            }
        })
    }
    
    // MARK: - Action
    
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
        
        cell.configure(lastName: person.lastName, firstName: person.firstName)
        
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
