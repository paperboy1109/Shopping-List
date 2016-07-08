//
//  ShoppingTableVC.swift
//  Shopping List
//
//  Created by Daniel J Janiak on 7/7/16.
//  Copyright © 2016 Daniel J Janiak. All rights reserved.
//

import UIKit
import CoreData

class ShoppingTableVC: UITableViewController {
    
    // MARK: - Properties 
    
    // var shoppingItemArray = [NSManagedObject]()//[String]()
    
    var managedObjectContext: NSManagedObjectContext!
    
    var groceries = [Grocery]()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedObjectContext = appDelegate.managedObjectContext
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }



    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groceries.count //shoppingItemArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ShoppingItemCell", forIndexPath: indexPath)
        
        let grocery = groceries[indexPath.row] //shoppingItemArray[indexPath.row]

        // cell.textLabel!.text = grocery.valueForKey("item") as? String //shoppingItemArray[indexPath.row]
        cell.textLabel?.text = grocery.item                

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
            
//            self.shoppingItemArray.append(textField!.text!)
//            self.shoppingItemArray.append(textField!.text!)
            
            /* Insert the item entered by the user into the shopping list entity */
            
            /*
            let entity = NSEntityDescription.entityForName("Grocery", inManagedObjectContext: self.managedObjectContext)
            let grocery = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: self.managedObjectContext)
            
            // (item is an attribute of the entity "Grocery" in the model
            grocery.setValue(textField!.text!, forKey: "item")
            */
            
            // An alternative approach that avoids errors that could result from mistyping the name of the key
            let grocery = NSEntityDescription.insertNewObjectForEntityForName("Grocery", inManagedObjectContext: self.managedObjectContext) as! Grocery
            
            grocery.item = textField!.text!
            
            /* Save the new item to the Grocery entity */
            
            do {
                try self.managedObjectContext.save()
            } catch {
                fatalError("The managed object context failed to save new item data")
            }
            
            self.loadData()
            
            
            
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
    
    // MARK: - Helpers
    
    func loadData() {
        let request = NSFetchRequest(entityName: "Grocery")
        
        do {
            let results = try managedObjectContext.executeFetchRequest(request)
            groceries = results as! [Grocery] //shoppingItemArray = results as! [NSManagedObject]
            tableView.reloadData()
        } catch {
            fatalError("Fetch request failed")
        }
    }
    

}
