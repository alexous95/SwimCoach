//
//  CreateUserController.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 20/02/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
import Firebase

class CreateUserController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var createAccount: UIButton!
    
    // MARK: - Variables
    
    let gradient = CAGradientLayer()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextfields()
        setupButton()
        prepareForAnimation()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = view.bounds
        setupBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startTexfieldsAnimation()
    }
    
   
    // MARK: - UI Setup
    
    /// Setsup the backgound with a gradient of color
    private func setupBackground() {
        guard let startColor = UIColor(named: "BackgroundStart")?.resolvedColor(with: self.traitCollection) else { return }
        guard let endColor = UIColor(named: "BackgroundEnd")?.resolvedColor(with: self.traitCollection) else { return }
        
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    /// Setsup the delegates and the design of the textfields
    private func setupTextfields() {
        username.delegate = self
        username.layer.borderColor = UIColor.white.cgColor
        username.layer.borderWidth = 1.0
        username.layer.cornerRadius = 10.0
        
        email.delegate = self
        email.layer.borderColor = UIColor.white.cgColor
        email.layer.borderWidth = 1.0
        email.layer.cornerRadius = 10.0
        
        password.delegate = self
        password.layer.borderColor = UIColor.white.cgColor
        password.layer.borderWidth = 1.0
        password.layer.cornerRadius = 10.0
    }
    
    /// Setsup the button's design
    private func setupButton() {
        createAccount.layer.borderWidth = 1.0
        createAccount.layer.borderColor = UIColor.white.cgColor
        createAccount.layer.cornerRadius = 10.0
    }
    
    // MARK: - Animations
    
    /// Configures the position before launching the animations
    private func prepareForAnimation() {
        username.center.x -= view.bounds.width
        email.center.x -= view.bounds.width
        password.center.x -= view.bounds.width
        createAccount.center.x -= view.bounds.width
    }
    
    
    /// Starts the animations for the textfields and buttons
    ///
    /// All the element on screen are coming from the left to the center of the screen.
    private func startTexfieldsAnimation() {
        UIView.animate(withDuration: 0.7, delay: 0.3, options: [.curveEaseInOut], animations: {
            self.username.center.x += self.view.bounds.width
        }, completion: nil)
        
        // Animation for the password textfield
        UIView.animate(withDuration: 0.7, delay: 0.4, options: [.curveEaseInOut], animations: {
            self.email.center.x += self.view.bounds.width
        }, completion: nil)
        
        // Animation for the login button
        UIView.animate(withDuration: 0.7, delay: 0.5, options: [.curveEaseInOut], animations: {
            self.password.center.x += self.view.bounds.width
        }, completion: nil)
        
        // Animation for the create button
        UIView.animate(withDuration: 0.7, delay: 0.6, options: [.curveEaseInOut], animations: {
            self.createAccount.center.x += self.view.bounds.width
        }, completion: nil)
    }
    
    // MARK: - Actions
    
    @IBAction func createAccount(_ sender: Any) {
        guard let username = username.text else { return }
        guard let email = email.text else { return }
        guard let password = password.text else { return }
        
        if email == "" || password == "" || password.count < 5 || username.count < 4 {
            let alert = UIAlertController(title: "Oops", message: "Check if your password is at leats 5 characters long. Check if your username is at least 3 character long.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true)
        } else {
            
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                if error != nil {
                    print(error.debugDescription)
                } else {
                    
                    print("inscription de \(username)")
                    guard let user = Auth.auth().currentUser else { return }
                    let userID = user.uid
                    
                    FirestoreService.database.collection("users").document(userID).setData(["username": username])
                    
                    self.performSegue(withIdentifier: "homeScreenSegue", sender: nil)
                }
            }
        }
    }
    
}

extension CreateUserController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}
