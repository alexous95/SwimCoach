//
//  ViewController.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 20/02/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit
import Firebase
import Combine

class LoginController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var create: UIButton!
    @IBOutlet weak var bubble1Image: UIImageView!
    @IBOutlet weak var bubble2Image: UIImageView!
    @IBOutlet weak var bubble3Image: UIImageView!
    @IBOutlet weak var activityWheel: UIActivityIndicatorView!
    
    // MARK: - Variables
    
    let gradient = CAGradientLayer()
    let screenHeight = UIScreen.main.bounds.height
    
    let viewModel = LoginViewModel()
    var activitySubscriber: AnyCancellable?
    var accessSubscriber: AnyCancellable?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createActivitySubscriber()
        createAccessSubscriber()
        setupGesture()
        setupBackground()
        setupTextFields()
        setupButton()
        prepareForAnimation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = view.bounds
        setupBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startAnimation()
    }
    
    // MARK: - Animation Methodes
    
    /// Configures the position before launching the animations
    private func prepareForAnimation() {
        email.center.x -= view.bounds.width
        password.center.x -= view.bounds.width
        login.center.x -= view.bounds.width
    }
    
    /// Starts all the animations
    private func startAnimation() {
        startTextFieldsAnimation()
        startBubbleAnimation()
    }
    
    /// Starts the animations for the textfields and buttons
    ///
    /// All the element on screen are coming from the left to the center of the screen.
    private func startTextFieldsAnimation() {
        
        // Animation for the username textfield
        UIView.animate(withDuration: 0.7, delay: 0.3, options: [.curveEaseInOut], animations: {
            self.email.center.x += self.view.bounds.width
        }, completion: nil)
        
        // Animation for the password textfield
        UIView.animate(withDuration: 0.7, delay: 0.4, options: [.curveEaseInOut], animations: {
            self.password.center.x += self.view.bounds.width
        }, completion: nil)
        
        // Animation for the login button
        UIView.animate(withDuration: 0.7, delay: 0.5, options: [.curveEaseInOut], animations: {
            self.login.center.x += self.view.bounds.width
        }, completion: nil)
        
        // Animation for the create button
        UIView.animate(withDuration: 0.7, delay: 0.6, options: [.curveEaseInOut], animations: {
            self.create.center.x += self.view.bounds.width
        }, completion: nil)
    }
    
    /// Starts the animations for the bubbles
    ///
    /// The bubble are going to the top of the screen with a fading effect
    private func startBubbleAnimation() {
        let transform = CGAffineTransform(translationX: 0, y: -screenHeight/1.2)
        
        // Animation for the first bubble
        
        UIView.animate(withDuration: 10.0, delay: 0.3, options: [.repeat, .curveEaseInOut], animations: {
            self.bubble1Image.center.y -= self.view.bounds.height
            self.bubble1Image.alpha = 0.0
        }, completion: { success in
            if success {
                self.bubble1Image.alpha = 1.0
            }
        })
        
        // Animation for the second bubble
        
        UIView.animate(withDuration: 8.0, delay: 0.3, options: [.repeat, .curveEaseInOut], animations: {
            self.bubble2Image.transform = transform
            self.bubble2Image.alpha = 0.0
        }, completion: { success in
            if success {
                self.bubble2Image.transform = .identity
                self.bubble2Image.alpha = 1.0
            }
        })
        
        // Animation for the third bubble
        
        UIView.animate(withDuration: 7.0, delay: 0.3, options: [.repeat, .curveEaseInOut], animations: {
            self.bubble3Image.transform = transform
            self.bubble3Image.alpha = 0.0
        }, completion: { success in
            if success {
                self.bubble3Image.transform = .identity
                self.bubble3Image.alpha = 1.0
            }
        })
    }
    
    // MARK: - UI Setup
    
    /// Setsup the background with a gradient of color
    private func setupBackground() {
        guard let startColor = UIColor(named: "BackgroundStart")?.resolvedColor(with: self.traitCollection) else { return }
        guard let endColor = UIColor(named: "BackgroundEnd")?.resolvedColor(with: self.traitCollection) else { return }
        
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        
    }
    
    /// Setsup the textfields with a white border and rounded corner and its delegate
    private func setupTextFields() {
        email.delegate = self
        email.layer.borderColor = UIColor.white.cgColor
        email.layer.borderWidth = 1.0
        email.layer.cornerRadius = 10.0
        
        password.delegate = self
        password.layer.borderColor = UIColor.white.cgColor
        password.layer.borderWidth = 1.0
        password.layer.cornerRadius = 10.0
    }
    
    /// Setsup the buttons with a white border and rounded corner
    private func setupButton() {
        login.layer.borderWidth = 1.0
        login.layer.borderColor = UIColor.white.cgColor
        login.layer.cornerRadius = 10.0
        
        create.layer.borderColor = UIColor.white.cgColor
        create.layer.borderWidth = 1.0
        create.layer.cornerRadius = 10.0
    }
    
    /// Configures a tap gesture to end dismiss the keyboard
    private func setupGesture() {
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(touchGesture)
    }
    
    // MARK: - Subscriber
    
    /// Create a subscriber to listen to update from the viewModel if the isLoading value change
    ///
    /// This function uses the Publisher/Subscriber model to update the interface accordingly to the modele.
    /// When the value isLoading change in the view model, the activity wheel start/stop animating accordingly
    private func createActivitySubscriber() {
        activitySubscriber = viewModel.$isLoading.receive(on: DispatchQueue.main).sink(receiveValue: { (value) in
            if value {
                self.activityWheel.isHidden = !value
                self.activityWheel.startAnimating()
            } else {
                self.activityWheel.isHidden = !value
                self.activityWheel.stopAnimating()
            }
        })
    }
        
    /// Create a subscriber to listen to update from the viewModel if the access value change
    ///
    /// This function uses the Publisher/Subscriber model to update the interface accordingly to the modele.
    /// When the value access change in the view model, we perform a segue if the value is true.
    /// If not we show an alert with the contextual error
    private func createAccessSubscriber() {
        accessSubscriber = viewModel.$access.receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink(receiveValue: { (access) in
                if access {
                    self.performSegue(withIdentifier: "homeScreenSegue", sender: nil)
                } else {
                    self.showAlert(withTitle: "Oops", message: self.viewModel.error.rawValue)
                }
            })
    }
    
    // MARK: - Actions
    
    @IBAction func login(_ sender: Any) {
        guard let email = email.text else { return }
        guard let password = password.text else { return }
        
        viewModel.authentificate(withEmail: email, password: password)
    }
    
    @objc private func endEditing() {
        email.resignFirstResponder()
        password.resignFirstResponder()
    }
}

extension LoginController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

