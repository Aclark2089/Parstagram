//
//  HomeViewController.swift
//  Parstagram
//
//  Created by Alex Clark on 2/21/16.
//  Copyright © 2016 R. Alex Clark. All rights reserved.
//

import UIKit
import Parse
import AFNetworking
import SVProgressHUD

let userDidLogoutNotification = "User Logged Out\n"

class HomeViewController: UIViewController {

    // Outlets
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    var refreshController: UIRefreshControl!
    var media: [PFObject]?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup tableview
        tableView.delegate = self
        tableView.dataSource = self
        
        // Setup refresh controller for table reload
        refreshController = UIRefreshControl()
        refreshController.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshController, atIndex: 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func callServerForUserMedia() {
        
        // Setup a PFQuery object to handle collection of the user's images
        let query = PFQuery(className: "UserMedia")
        
        // Order the media gathered by creation date, include author and set limit # of media returned
        query.orderByAscending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        SVProgressHUD.show()
        
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) ->
        Void in
            // If we are able to get new userMedia, then set out new media as the new userMedia object
            if let media = media {
                
                // Reset user media object for the tableview data, reload table to display it
                self.media = media
                self.tableView.reloadData()
                
                // Dismiss the progress bar for loading the media
                SVProgressHUD.dismiss()
                
            }
            // Unable to get new user media
            else {
                if let error = error {
                    // Log error
                    NSLog("Error: Unable to query new user media objects\n\(error)")
                }
                
            }
        }
        
    
    }
    
    
    
    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) ->
        Void in
        
            if let error = error {
                // Log
                NSLog("Error on logout:\n\(error.localizedDescription)")
            }
            else {
                
                // Log
                NSLog("Logout Success")
                //Broadcast
                NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
                
            }
        
        }
        
    }
    
    // Delay duration for onRefresh function
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    // Handle refreshController action
    func onRefresh() {
        delay(2, closure: {
            self.refreshController.endRefreshing()
        })
        
        // Query Media from Server
        callServerForUserMedia()
        
        self.refreshController?.endRefreshing()
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

// Tableview Extension for Delegate and Datasource of Tableview
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Total number of rows in each section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    // Number of sections in tableview == number of media objects we gathered, else 0 cells we have to show
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if (media != nil) {
            return media!.count
        }
        else {
            return 0
        }
    }
    
    
    // Setup header for each cell, which has the properties from the media object
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // Main header
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
//        // Profile view to be added to header
//        let profileView = UIImageView(frame: CGRect(x: 10, y: 2, width: 25, height: 25))
//        profileView.clipsToBounds = true
//        profileView.layer.cornerRadius = 15;
//        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
//        profileView.layer.borderWidth = 1;
//        
//        // Use the section number to get the right URL
//        let cellMedia = media![section]
//        profileView.setImageWithURL(NSURL(string: cellMedia["user"]!["profile_picture"] as! String)!)
//        
//        // Username to be added to header
//        let usernamelabel = UILabel(frame: CGRect(x: 60, y: 2, width: 200, height: 25))
//        usernamelabel.clipsToBounds = true
//        usernamelabel.text = picture["user"]!["username"] as? String
//        
//        // Add views to header
//        headerView.addSubview(profileView)
//        headerView.addSubview(usernamelabel)
        
        // Return cell header
        return headerView
        
    }
    
    // Deselection animation for each table view cell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
    }
    
    // Working with each media cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("MediaTableViewCell", forIndexPath: indexPath) as! MediaTableViewCell
        return cell
    }

}
