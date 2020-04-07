//
//  TrainingGroupController.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 24/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit
import Combine

class TrainingGroupController: UIViewController {
    
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
        setupNavBar()
        createActivitySubscriber()
        createDataAvaillableSubscriber()
        setupCollectionDelegate()
        loadData()
    }
    
    // Sets the gradient's frame to the new bounds of the view to apply dark mode correctly
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = view.bounds
        setupBackground(gradient: gradient)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "monthSegue" {
            let destVC: MonthController = segue.destination as! MonthController
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
}

// MARK: - Extension

extension TrainingGroupController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItem()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "groupeCell", for: indexPath) as? FolderCollectionViewCell else {
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
