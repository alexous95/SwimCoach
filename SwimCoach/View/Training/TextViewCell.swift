//
//  TextViewCell.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 26/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import UIKit

class TextViewCell: UITableViewCell {

    @IBOutlet weak var trainingText: UITextView!
    var textChanged: ((String) -> Void)?
    var textViewClearedOnInitialEdit = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        trainingText.delegate = self
        trainingText.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender: )))
    }
    
    func configure(text: String) {
        trainingText.text = text
    }
    func configureWithTitle(_ title: String, text: String) {
        trainingText.text = title + "\n\n" + text
    }
    
    func textChange(action: @escaping (String) -> Void) {
        self.textChanged = action
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
    }
    
    // MARK: - Private
    
    @objc private func tapDone(sender: Any){
        trainingText.resignFirstResponder()
    }
}

extension TextViewCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !textViewClearedOnInitialEdit {
            textView.text = ""
            textView.textColor = .white
            textViewClearedOnInitialEdit = true
        }
       
    }
}
