//
//  CreateUserController.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 20/02/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
import Firebase
import Combine

class CreateUserController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var createAccount: UIButton!
    @IBOutlet weak var activityWheel: UIActivityIndicatorView!
    
    // MARK: - Variables
    
    let gradient = CAGradientLayer()
    let viewModel = CreateUserViewModel()
    var isKeyboardAppear = false
    
    var accessSubscriber: AnyCancellable?
    var loadingSubscriber: AnyCancellable?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createActivitySubscriber()
        createAccessSubscriber()
        setupTextfields()
        setupButton()
        prepareForAnimation()
        setupNotification()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = view.bounds
        setupBackground(gradient: gradient)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        prepareForAnimation()
        startTexfieldsAnimation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        prepareForAnimation()
    }
    
    
    // MARK: - Setup
    
    /// Setsup the notifications
    private func setupNotification() {
        // We use this notification to update our interface if needed when the keyboard appear
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        
        // We use this notification to update our interface if needed when the keyboard disappear
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: self.view.window)
    }
    
    // MARK: - UI Setup

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
    
    // MARK: - Subscribers
    
    /// Create a subscriber to listen for update from the viewModel if the isLoading value change
    ///
    /// This function uses the Publisher/Subscriber model to update the interface accordingly to the modele.
    /// When the value isLoading change in the view model, the activity wheel start/stop animating accordingly
    private func createActivitySubscriber() {
        loadingSubscriber = viewModel.$isLoading.receive(on: DispatchQueue.main).sink(receiveValue: { (loading) in
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
    
    // MARK: - OBJC
    
    /// This function is used in the selector of the notification
    /// - Parameter notification: An NSNotification object to retrieve the keyboardsize of the device
    ///
    /// This function update our frame when the keyboard is hidding our element
    @objc func keyboardWillShow(notification: NSNotification) {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return
        default:
            if !isKeyboardAppear {
                if username.isFirstResponder {
                    return
                }
                guard let userInfo = notification.userInfo else { return }
                guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
                let keyboardFrame = keyboardSize.cgRectValue
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardFrame.height
                }
            }
            isKeyboardAppear = true
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return
        default:
            if isKeyboardAppear {
                if username.isFirstResponder {
                    return
                }
                guard let userInfo = notification.userInfo else { return }
                guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
                let keyboardFrame = keyboardSize.cgRectValue
                if self.view.frame.origin.y != 0 {
                    self.view.frame.origin.y += keyboardFrame.height
                }
            }
            isKeyboardAppear = false
        }
    }
    
    // MARK: - Actions
    
    @IBAction func createAccount(_ sender: Any) {
        guard let username = username.text else { return }
        guard let email = email.text else { return }
        guard let password = password.text else { return }
        
        viewModel.createUser(withUsername: username, email: email, password: password)

    }
    
}

extension CreateUserController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}
