//
//  HomeScreenController.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 20/02/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit
import Combine

class HomeScreenController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityWheel: UIActivityIndicatorView!
    
    // MARK: - Variables

    let gradient = CAGradientLayer()
    let viewModel = HomeScreenViewModel()
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = view.bounds
        setupBackground()
    }
    
    // MARK: - Setup UI
    
    private func setupCollectionDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
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
    
    private func loadData() {
        viewModel.fetchGroup()
    }
    
    // MARK: - Subscribers
    
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
    
    private func createDataAvaillableSubscriber() {
        availlableDataSubscriber = viewModel.$dataAvaillable.receive(on: DispatchQueue.main).sink(receiveValue: { (data) in
            if data {
                self.collectionView.reloadData()
            }
        })
    }
    
    // MARK: - Action
    
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
        
        alert.addAction(save)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
}

// MARK: - Extension

extension HomeScreenController: UICollectionViewDelegate, UICollectionViewDataSource {
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
