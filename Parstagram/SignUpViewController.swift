//
//  SignUpViewController.swift
//  Parstagram
//
//  Created by Alex Clark on 2/21/16.
//  Copyright © 2016 R. Alex Clark. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
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
    
    
    
    // User Sign Up Feature
    @IBAction func onSignUp(sender: AnyObject) {
        
        // Create our new user to save
        let newUser = PFUser()
        
        // Set fields
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        // Signup user we created w/ username & password
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            // If we succeed, perform segue
            if (success) {
                
                // Log user creation, Move to Timeline Controller
                NSLog("\nCreated a user with Sign Up")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
                
            }
                
                // Couldn't sign up user
            else {
                
                // Log creation failure
                NSLog("\nUser Creation from Sign Up Failed\nError: \(error?.localizedDescription)")
                
            }
            
        }
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
