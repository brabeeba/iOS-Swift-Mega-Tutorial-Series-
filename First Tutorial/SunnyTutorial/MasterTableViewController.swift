//
//  MasterTableViewController.swift
//  SunnyTutorial
//
//  Created by Brabeeba Wang on 8/20/15.
//  Copyright (c) 2015 Brabeeba Wang. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController {
    let dataFromNetworking: [String: [String] ] = ["水果": ["香蕉", "頻果"], "人": ["Brabeeba", "Sunny"], "動物":["cat", "dog", "lion"]]
    
    var dataHolder = [0: [" ", " "], 1: [" ", " "], 2: [" ", " ", " "]]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        title = "第一頁"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return dataFromNetworking.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return dataFromNetworking[dataFromNetworking.keys.array[section]]!.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
    

        cell.textLabel?.text = dataFromNetworking[dataFromNetworking.keys.array[indexPath.section]]![indexPath.row]
        
        cell.detailTextLabel!.text = dataHolder[indexPath.section]![indexPath.row]
        print (cell.detailTextLabel!.text!)
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataFromNetworking.keys.array[section]
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("next", sender: dataFromNetworking[dataFromNetworking.keys.array[indexPath.section]]![indexPath.row])
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        let nextView = segue.destinationViewController as! NextTableViewController
        if let selectedRow = tableView.indexPathForSelectedRow() {
            nextView.content = dataFromNetworking [dataFromNetworking.keys.array[selectedRow.section]]![selectedRow.row]
            nextView.currentPath = selectedRow
        }
        
        nextView.tempHolder = dataHolder
        nextView.delegate = self
        
    }
    

}
extension MasterTableViewController: nextDelegate {
    func updateData( data: AnyObject) {
        dataHolder = data as! [Int: [String]]
        tableView.reloadData()
    }
}
    
    
    
    
