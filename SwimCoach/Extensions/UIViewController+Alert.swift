//
//  UIViewController+Alert.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 16/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Shows an alert with a custom title and message
    ///
    /// - Parameter title: The alert's title
    /// - Parameter message: The alert's message
    func showAlert(withTitle title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
}
