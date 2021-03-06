//
//  ProjectTableViewController.swift
//  srvup
//
//  Created by Justin Mitchel on 6/16/15.
//  Copyright (c) 2015 Coding for Entrepreneurs. All rights reserved.
//

import UIKit

import KeychainAccess

class ProjectTableViewController: UITableViewController {
    var projects = [Project]()
    let keychain = Keychain(service: "com.codingforentrepreneurs.srvup")

    let user = User()
    
    override func viewWillAppear(animated: Bool) {
        user.checkToken()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blackColor()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        let btn = UINavButton(title: "Logout", direction: UIButtonDirection.Right, parentView: self.tableView)
        btn.addTarget(self, action: "doLogout:", forControlEvents: UIControlEvents.TouchUpInside)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        self.tableView.addSubview(btn)
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.projects.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ProjectTableCell
        let project = self.projects[indexPath.row]
        // Configure the cell...
        // cell.textLabel?.text = "\(indexPath.row + 1) - \(self.projects[indexPath.row].title)"
        if project.imageUrlString != nil {
            let imageUrl = NSURL(string: project.imageUrlString!)
            let data = NSData(contentsOfURL: imageUrl!)
            let image = UIImage(data: data!)
            // let imageView = UIimageView()
            cell.projectImage.image = image
        }
        cell.backgroundColor = self.view.backgroundColor
        cell.projectLabel.text = "\(project.title)"
        return cell
    }

    

    func doLogout(sender:AnyObject) {
        // println("logout")
        self.keychain["token"] = nil
        self.navigationController?.popViewControllerAnimated(true)
        self.dismissViewControllerAnimated(true, completion: nil)
        
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
        let vc = segue.destinationViewController as! LectureListTableViewController
        let indexPath = self.tableView.indexPathForSelectedRow()
        let project = self.projects[indexPath!.row]
        vc.project = project
        
    }
    

}
