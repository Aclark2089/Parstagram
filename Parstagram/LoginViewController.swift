//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Alex Clark on 2/16/16.
//  Copyright © 2016 R. Alex Clark. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {


    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // User Sign In Feature
    @IBAction func onSignIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) {
            (user: PFUser?, error: NSError?) ->
            Void in
            
            // User logged in, we're out of here
            if (user != nil) {
                
                // Log Success, Move to Timeline Controller
                NSLog("\nLogin Successful With User \(user)")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
                
            }
            // Error in logging user in
            else {
                
                // See if we can read the error code and then alert user to the issue if it is something we understand
                if let error = error {
                    
                    if (error.code == 101) {
                        
                        // Username / Password combination not found or was incorrect
                        let alert = UIAlertController(title: "Username / Password Incorrect", message: "", preferredStyle: .Alert)
                        let OkAction = UIAlertAction(title: "OK", style: .Default) { (action) in }
                        alert.addAction(OkAction)
                        self.presentViewController(alert, animated: true) {}
                        
                    }
                    
                    // Log Failure
                    NSLog("\nLogin Unsuccessful\nError: \(error.localizedDescription)")
                    
                }
                
            }
        
        }
    
    }

}
