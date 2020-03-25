//
//  TrainingController.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 25/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit

class MonthController: UIViewController {

    var group: Group?
    
    let gradient = CAGradientLayer()
    let viewModel = MonthViewModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupDelegate()
    }
    
    override func viewDidLayoutSubviews() {
        gradient.frame = view.bounds
        setupBackground()
    }
    
    // MARK: - Setup
    
    private func setupDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - UI Setup
    
    private func setupBackground() {
        guard let backStartColor = UIColor(named: "BackgroundStart")?.resolvedColor(with: self.traitCollection) else { return }
        guard let backEndColor = UIColor(named: "BackgroundEnd")?.resolvedColor(with: self.traitCollection) else { return }
        
        gradient.colors = [backStartColor.cgColor, backEndColor.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    
}

// MARK: - Extension

extension MonthController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItem()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "monthCell", for: indexPath) as? FolderCollectionViewCell else { return UICollectionViewCell() }
        
        let month = viewModel.months[indexPath.item]
        
        cell.configure(name: month)
        
        return cell
    }
    
    
}
