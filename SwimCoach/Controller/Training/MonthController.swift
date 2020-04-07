//
//  TrainingController.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 25/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit

class MonthController: UIViewController {

    // MARK: - Variable
    
    var group: Group?
    
    let gradient = CAGradientLayer()
    let viewModel = MonthViewModel()
    
    // MARK: - Outlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupDelegate()
    }
    
    override func viewDidLayoutSubviews() {
        gradient.frame = view.bounds
        setupBackground(gradient: gradient)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "trainingSegue" {
            let destVC: TrainingController = segue.destination as! TrainingController
            destVC.group = group
            
            let indexPath = collectionView.indexPathsForSelectedItems
        
            guard let index = indexPath else { return }
            let item = index[0].item
            destVC.navigationItem.title = viewModel.months[item]
            destVC.month = viewModel.months[item]
        }
    }
    
    // MARK: - Setup
    
    private func setupDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - UI Setup
    
    private func setupNavBar() {
        self.navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: UIColor.white)
    }
    
}

// MARK: - Extension

extension MonthController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItem()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "monthCell", for: indexPath) as? FolderCollectionViewCell else { return UICollectionViewCell() }
        
        let month = viewModel.months[indexPath.item]
        
        cell.configure(name: month)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return CGSize(width: (view.frame.width / 3) - 15, height: 150)
        default:
            return CGSize(width: (view.frame.width / 3) - 15, height: 110)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    
}
