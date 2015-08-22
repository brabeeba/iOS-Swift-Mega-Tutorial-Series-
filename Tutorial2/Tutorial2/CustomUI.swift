//
//  CustomUI.swift
//  Tutorial2
//
//  Created by Brabeeba Wang on 8/21/15.
//  Copyright (c) 2015 Brabeeba Wang. All rights reserved.
//

import UIKit
import Foundation


class NumberCell: UITableViewCell {
    
    var label1: UILabel
    var label2: UILabel
    var label3: UILabel
    
    var number: ThreeNumber? {
        didSet {
            if let data = number {
                label1.text = "Left: \(data.left)"
                label2.text = "Right: \(data.right)"
                label3.text = "Bottom: \(data.bottom)"
            }
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        label1 = UILabel(frame: CGRect.nullRect)
        label2 = UILabel(frame: CGRect.nullRect)
        label3 = UILabel(frame: CGRect.nullRect)
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(label1)
        self.addSubview(label2)
        self.addSubview(label3)
        
        label1.setTranslatesAutoresizingMaskIntoConstraints(false)
        label2.setTranslatesAutoresizingMaskIntoConstraints(false)
        label3.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let viewdictionary = ["label1": label1, "label2": label2, "label3": label3]
        
        let viewLayoutConstraintV = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[label1]-[label2]-[label3]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewdictionary)
        let label1LayoutConstraintH = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[label1]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewdictionary)
        let label2LayoutConstraintH = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[label2]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewdictionary)
        let label3LayoutConstraintH = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[label3]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewdictionary)
        
        self.addConstraints(viewLayoutConstraintV)
        self.addConstraints(label1LayoutConstraintH)
        self.addConstraints(label2LayoutConstraintH)
        self.addConstraints(label3LayoutConstraintH)
        
        self.setNeedsLayout()
    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
