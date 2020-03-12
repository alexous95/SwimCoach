//
//  ViewController.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 20/02/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit
import Firebase

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
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGesture()
        setupBackground()
        setupTextFields()
        setupButton()
        setupActivityWheel()
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
    
    private func setupActivityWheel() {
        activityWheel.isHidden = true
    }
    /// Configures a tap gesture to end dismiss the keyboard
    private func setupGesture() {
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(touchGesture)
    }
    
    
    // MARK: - Actions
    
    @IBAction func login(_ sender: Any) {
        guard let email = email.text else { return }
        guard let password = password.text else { return }
        
        if email == "" || password == "" || password.count < 5 {
            let alert = UIAlertController(title: "Oops", message: "You need to fill correctly the fields", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true)
        } else {
            activityWheel.isHidden = false
            activityWheel.startAnimating()
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    print(error.debugDescription)
                    
                    let alert = UIAlertController(title: "Oops", message: "Error while authentificating you", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    
                    alert.addAction(action)
                    self.present(alert, animated: true)
                    
                } else {
                    print("authentification successful")
                    self.activityWheel.stopAnimating()
                    self.activityWheel.isHidden = true
                    self.performSegue(withIdentifier: "homeScreenSegue", sender: nil)
                }
            }
        }
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

