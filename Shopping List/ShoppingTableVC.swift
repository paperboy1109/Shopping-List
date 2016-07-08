//
//  ShoppingTableVC.swift
//  Shopping List
//
//  Created by Daniel J Janiak on 7/7/16.
//  Copyright © 2016 Daniel J Janiak. All rights reserved.
//

import UIKit

class ShoppingTableVC: UITableViewController {
    
    // MARK: - Properties 
    
    var shoppingItemArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shoppingItemArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ShoppingItemCell", forIndexPath: indexPath)

        cell.textLabel?.text = shoppingItemArray[indexPath.row]

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // MARK: - Actions
    
    @IBAction func addTapped(sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Shopping List", message: "Add Item", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) in
        }
        
        /* User adds a new item*/
        let addConfirmed = UIAlertAction(title: "Add", style: UIAlertActionStyle.Default) { (action: UIAlertAction) in
            
            let textField = alert.textFields?.first
            
            self.shoppingItemArray.append(textField!.text!)
            
            self.tableView.reloadData()
        }
        
        alert.addAction(addConfirmed)
        
        /* User cancels */
        
        let cancelAdd = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) { (action: UIAlertAction) in
            
        }
        
        alert.addAction(cancelAdd)
        
        /* Display the alert */
        presentViewController(alert, animated: true, completion: nil)
    }
    

}
