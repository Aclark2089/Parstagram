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
        
        // Query Media from Parse Server
        //callParseServerForImages()
        
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

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("MediaTableViewCell", forIndexPath: indexPath) as! MediaTableViewCell
        return cell
    }

}
