//
//  UITextView+Toolbar.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 02/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit

extension UITextView {
    
    /// Adds a done Button to textview's keyboard
    ///
    /// - Parameter title: The button's title
    /// - Parameter target: The object in wich we add the button
    /// - Parameter selector: The action performed when the button is pressed
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
}
