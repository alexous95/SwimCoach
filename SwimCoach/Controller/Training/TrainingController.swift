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

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityWheel: UIActivityIndicatorView!
    
    let gradient = CAGradientLayer()
    let viewModel = TrainingViewModel()
    
    var group: Group?
    var month: String?
    
    var activitySubscriber: AnyCancellable?
    var availlableDataSubscriber: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createActivitySubscriber()
        createDataSubscriber()
        setupDelegate()
        loadData()
    }

    override func viewDidLayoutSubviews() {
        gradient.frame = view.bounds
        setupBackground(gradient: gradient)
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
    
    private func loadData() {
        guard let group = group else { return }
        guard let month = month else { return }
        viewModel.fetchWorkout(from: group, for: month)
    }
    
    // MARK: - UI Setup
        
    // MARK: - Subscriber
    
    /// Creates a subscriber for activity evenment
    ///
    /// When the view model change his state it is reflected on the view controller with the activity subscriber.
    /// The activity subscriber then activate or stop the activity indicator view
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
    
    private func createDataSubscriber() {
        availlableDataSubscriber = viewModel.$dataAvaillable.receive(on: DispatchQueue.main).sink(receiveValue: { (data) in
            if data {
                self.collectionView.reloadData()
            }
        })
    }
}

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
    
}
