//
//  CustomUI.swift
//  SunnyTutorial
//
//  Created by Brabeeba Wang on 8/20/15.
//  Copyright (c) 2015 Brabeeba Wang. All rights reserved.
//

import UIKit
import Foundation

protocol TextCellDelegate {
    func didEndEdit (text: String)
}

class TextCell: UITableViewCell, UITextFieldDelegate {
    var textForm: UITextField
    
    var delegate: TextCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        textForm = UITextField(frame: CGRect.nullRect)
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textForm.delegate = self
        self.addSubview(textForm)
        textForm.setTranslatesAutoresizingMaskIntoConstraints(false)
        let viewdictionary = ["text": textForm]
        let textLayoutConstraintH = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[text]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewdictionary)
        let textLayoutConstraintV = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[text]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewdictionary)
        self.addConstraints(textLayoutConstraintH)
        self.addConstraints(textLayoutConstraintV)
        self.setNeedsLayout()
        
        
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textForm.endEditing(true)
        return true
    }

    func textFieldDidEndEditing(textField: UITextField) {
        delegate?.didEndEdit(textField.text)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
