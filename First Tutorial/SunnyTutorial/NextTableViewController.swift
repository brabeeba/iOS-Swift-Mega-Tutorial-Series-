//
//  NextTableViewController.swift
//  SunnyTutorial
//
//  Created by Brabeeba Wang on 8/20/15.
//  Copyright (c) 2015 Brabeeba Wang. All rights reserved.
//

import UIKit

protocol nextDelegate {
    func updateData(data: AnyObject)
}

class NextTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    var content: String?
    var tableView: UITableView!
    
    var tempHolder: [Int: [String]]?
    var currentPath: NSIndexPath?
    
    let tempData = ["1", "2", "3"]
    
    var delegate: nextDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = content
        
        tableView = UITableView(frame: CGRect.nullRect, style: UITableViewStyle.Grouped)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "nextCell")
        tableView.registerClass(TextCell.self, forCellReuseIdentifier: "text")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        let viewdictionary = ["table": tableView]
        
        let tableLayoutConstraintH = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[table]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewdictionary)
        
        let tableLayoutConstraintV = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[table]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewdictionary)
        
        view.addConstraints(tableLayoutConstraintV)
        view.addConstraints(tableLayoutConstraintH)
        
        view.setNeedsLayout()
        
        switch content! {
        case "Brabeeba", "Sunny":
            let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "pressedDone")
            navigationItem.rightBarButtonItem = doneButton
        default:()
        }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap")
        gestureRecognizer.delegate = self
        view.addGestureRecognizer(gestureRecognizer)
        
        // Do any additional setup after loading the view.
    }
    func pressedDone () {
        view.endEditing(true)
        navigationController?.popViewControllerAnimated(true)
        delegate?.updateData(tempHolder!)
        
    }
    
    func handleTap () {
        view.endEditing(true)
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch content! {
        case "Brabeeba", "Sunny":
            return 1
        default:
            return tempData.count
        }
        
    }
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        switch content! {
        case "Brabeeba", "Sunny":
            return true
        default:
            return false
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch content! {
        case "Brabeeba", "Sunny":
            let cell = tableView.dequeueReusableCellWithIdentifier("text", forIndexPath: indexPath) as! TextCell
            cell.delegate = self
            cell.textForm.text = tempHolder![currentPath!.section]![currentPath!.row]
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("nextCell", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = tempData[indexPath.row]
            
            if cell.textLabel?.text == tempHolder![currentPath!.section]![currentPath!.row] {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch content! {
        case "Brabeeba", "Sunny":
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        default:
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            tempHolder![currentPath!.section]![currentPath!.row] = cell!.textLabel!.text!
            navigationController?.popViewControllerAnimated(true)
            delegate?.updateData(tempHolder!)
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension NextTableViewController: TextCellDelegate {
    func didEndEdit(text: String) {
        tempHolder![currentPath!.section]![currentPath!.row] = text
    }
}
