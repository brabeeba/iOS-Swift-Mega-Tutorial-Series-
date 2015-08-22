//
//  ViewController.swift
//  Tutorial2
//
//  Created by Brabeeba Wang on 8/21/15.
//  Copyright (c) 2015 Brabeeba Wang. All rights reserved.
//

import Alamofire
import SwiftyJSON

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var populatingCell = false
    
    var tableView: UITableView!
    
    var currentUnit = 0
    
    var unitLength = 10
    
    var numberList = [ThreeNumber]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateCell()
        tableView = UITableView(frame: CGRect.nullRect, style: UITableViewStyle.Plain)
        
        tableView.registerClass(NumberCell.self, forCellReuseIdentifier: "number")
        
        tableView.estimatedRowHeight = 93.5
        tableView.rowHeight = UITableViewAutomaticDimension
        
       
       
        
        view.addSubview(tableView)
        
        tableView.showsVerticalScrollIndicator = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        let viewdictionary = ["table": tableView]
        
        let tableLayoutConstraintH = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[table]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewdictionary)
        let tableLayoutConstraintV = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[table]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewdictionary)
        
        view.addConstraints(tableLayoutConstraintV)
        view.addConstraints(tableLayoutConstraintH)
        
        view.setNeedsLayout()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("number", forIndexPath: indexPath) as! NumberCell
        
        cell.number = numberList[indexPath.row]
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let viewHeight = view.bounds.height
        
        if scrollView.contentOffset.y + viewHeight > scrollView.contentSize.height * 0.7 {
        
            populateCell()
        }
    }
    
    func populateCell () {
        if populatingCell {
            return
        }
        populatingCell = true
        
        Alamofire.request(API.Router.Inquiry(currentUnit * unitLength + 1, (currentUnit + 1) * unitLength)).validate().responseCollection {
            (a, b, numbers: [ThreeNumber]?, error) in
            
            let lastItem = self.numberList.count
            self.numberList.extend(numbers!)
            
            
            
            let indexPaths = (lastItem..<self.numberList.count).map {
                (var int) -> NSIndexPath in
                return NSIndexPath(forRow: int, inSection: 0)
            }
            
            self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.None)
            
            self.currentUnit += 1
            self.populatingCell = false
        }
        
    }


}

