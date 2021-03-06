//
//  TrainingController.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 25/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit
import Combine

class TrainingController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityWheel: UIActivityIndicatorView!
    
    // MARK: - Variables
    
    /// The gradient object we use to apply our gradient colors
    let gradient = CAGradientLayer()
    
    /// The viewModel that manage the data for our controller
    let viewModel = TrainingViewModel()
    
    /// The group choosen by the user
    var group: Group?
    
    /// The month choosen by the user
    var month: String?
    
    /// The property that will subscribe to the publisher from the view model
    var activitySubscriber: AnyCancellable?
    
    /// The property that will subscribe to the publisher from the view model
    var availlableDataSubscriber: AnyCancellable?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createActivitySubscriber()
        createDataSubscriber()
        setupDelegate()
    }

    override func viewDidLayoutSubviews() {
        gradient.frame = view.bounds
        setupBackground(gradient: gradient)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailWorkout" {
            let destVC: DetailWorkoutController = segue.destination as! DetailWorkoutController
            let indexPath = collectionView.indexPathsForSelectedItems
            guard let index = indexPath else { return }
            let item = index[0].item
            
            guard let workouts = viewModel.workouts else { return }
            destVC.workout = workouts[item]
            destVC.group = group
            destVC.month = month
        }
        
        if segue.identifier == "addWorkoutLineSegue" {
            let destVC: AddWorkoutLineController = segue.destination as! AddWorkoutLineController
            
            guard let group = group else { return }
            guard let month = month else { return }
            
            destVC.group = group
            destVC.month = month
        }
    }
    
    // MARK: - Setup
    
    /// Setsup the delegate for the collection view
    private func setupDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    /// Loads data from the viewModel
    private func loadData() {
        guard let group = group else { return }
        guard let month = month else { return }
        viewModel.fetchWorkout(from: group, for: month)
    }
    
    /// Deletes the selected item
    private func deleteItem(at indexPath: IndexPath) {
        guard let group = group, let month = month, let workouts = viewModel.workouts else { return }
        viewModel.deleteWorkout(from: group, for: month, workout: workouts[indexPath.item])
    }
    
        
    // MARK: - Subscriber
    
    /// Creates a subscriber for activity evenment
    ///
    /// When the view model change his state it is reflected on the view controller with the activity subscriber.
    /// The activity subscriber then activate or stop the activity indicator view
    private func createActivitySubscriber() {
        activitySubscriber = viewModel.$isLoading.receive(on: DispatchQueue.main).sink(receiveValue: { (loading) in
            if loading {
                self.collectionView.isHidden = loading
                self.activityWheel.isHidden = !loading
                self.activityWheel.startAnimating()
            } else {
                self.collectionView.isHidden = loading
                self.activityWheel.isHidden = !loading
                self.activityWheel.stopAnimating()
            }
        })
    }
    
    private func createDataSubscriber() {
        availlableDataSubscriber = viewModel.$dataAvaillable.receive(on: DispatchQueue.main).sink(receiveValue: { (data) in
            if data {
                self.collectionView.reloadData()
            }
        })
    }
}

// MARK: - Collection View Extension

extension TrainingController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItem()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trainingCell", for: indexPath) as? TrainingCollectionViewCell else { return UICollectionViewCell() }
        guard let workouts = viewModel.workouts else { return UICollectionViewCell() }
        
        let workout = workouts[indexPath.item]
        cell.configure(date: workout.date, titreSeance: workout.title, distance: String(workout.getDistance()))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return CGSize(width: (view.frame.width / 3) - 20, height: 150)
        default:
            return CGSize(width: (view.frame.width / 2) - 20, height: 110)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let index = indexPath.item
        
        let identifier = "\(index)" as NSString
        
        let configuration = UIContextMenuConfiguration(identifier: identifier, previewProvider: nil) { action in
            
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), attributes: .destructive, handler: { action in
                self.deleteItem(at: indexPath)
            })
            
            return UIMenu(title: "", image: nil, identifier: nil, options: [.displayInline], children: [delete])
        }
        
        return configuration
    }
}
