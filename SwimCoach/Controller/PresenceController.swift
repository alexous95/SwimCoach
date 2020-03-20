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
    let cellSpacingHeight: CGFloat = 15
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        setupBackground()
        setupNavBar()
        initialiseViewModel()
        setupDelegate()
        createActivitySubscriber()
        createAvaillableDataSubscriber()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = view.bounds
        setupBackground()
    }
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Private
    
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
    
    private func addBlurEffect() {
        
    }
    
    private func setupBackground() {
        guard let backStartColor = UIColor(named: "BackgroundStart")?.resolvedColor(with: self.traitCollection) else { return }
        guard let backEndColor = UIColor(named: "BackgroundEnd")?.resolvedColor(with: self.traitCollection) else { return }
        
        gradient.colors = [backStartColor.cgColor, backEndColor.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    private func setupNavBar() {
        self.navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: UIColor.white)
    }
    
}

extension PresenceController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // To access our future array we will have to use indexPath.section rather than row
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as? PersonViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(lastName: "test", firstName: "test")
        
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
    
    
}
