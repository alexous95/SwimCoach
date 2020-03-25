//
//  HomeScreenController.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 20/02/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit
import Combine

class GroupController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityWheel: UIActivityIndicatorView!
    
    // MARK: - Variables

    let gradient = CAGradientLayer()
    let viewModel = GroupViewModel()
    
    var activitySubscriber: AnyCancellable?
    var availlableDataSubscriber: AnyCancellable?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createActivitySubscriber()
        createDataAvaillableSubscriber()
        setupCollectionDelegate()
        setupNavBar()
        loadData()
    }
    
    // Sets the gradient's frame to the new bounds of the view to apply dark mode correctly
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = view.bounds
        setupBackground()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presenceSegue" {
            let destVC: PresenceController = segue.destination as! PresenceController
            let indexPath = collectionView.indexPathsForSelectedItems
            
            guard let groups = viewModel.groups else { return }
            guard let index = indexPath else { return }
            
            let item = index[0].item
            destVC.navigationItem.title = groups[item].groupName
            destVC.group = groups[item]
        }
    }
    
    // MARK: - Setup UI
    
    /// Setsup the collection view delegate and data source
    private func setupCollectionDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    /// Setsup the background
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
    
    // Loads data from the view model
    private func loadData() {
        viewModel.fetchGroup()
    }
    
    // MARK: - Subscribers
    
    /// Create a subscriber to listen for update from the viewModel if the isLoading value change
    ///
    /// This function uses the Publisher/Subscriber model to update the interface accordingly to the modele.
    /// When the value isLoading change in the view model, the activity wheel start/stop animating accordingly
    private func createActivitySubscriber() {
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
    private func createDataAvaillableSubscriber() {
        availlableDataSubscriber = viewModel.$dataAvaillable.receive(on: DispatchQueue.main).sink(receiveValue: { (data) in
            if data {
                self.collectionView.reloadData()
            }
        })
    }
    
    // MARK: - Action
    
    /// Shows an alert to request the name of the new group and saves it to the database
    @IBAction func addGroup() {
        let alert = UIAlertController(title: "Add group", message: "Choose a name", preferredStyle: .alert)
        
        alert.addTextField { (textfield) in
            textfield.placeholder = "Choose a name"
            textfield.textColor = .black
        }
        
        let save = UIAlertAction(title: "Add", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            guard let text = textField.text else { return }
            
            if text != "" {
                self.viewModel.addGroup(groupName: text)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(save)
        
        present(alert, animated: true)
    }
    
}

// MARK: - Extension

extension GroupController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItem()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "groupeCell", for: indexPath) as? FolderCollectionViewCell else {
            print("Ca a pas marché")
            return UICollectionViewCell()
            
        }
        guard let groups = viewModel.groups else {
            return UICollectionViewCell()
        }
        
        let group = groups[indexPath.item]
        
        cell.configure(name: group.groupName)
        
        return cell
    }
}