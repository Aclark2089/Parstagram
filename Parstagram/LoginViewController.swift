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
            
            // We got user
            if (user != nil) {
                
                // Log Success, Move to Timeline Controller
                NSLog("\nLogin Successful With User \(user)")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
                
            }
            // No user
            else {
                
                // Log Failure
                NSLog("\nLogin Unsuccessful\nError: \(error)")
                
            }
            
        
        }
    
    }

}
