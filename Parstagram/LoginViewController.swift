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
            if (user != nil) {
                
                // Log Success, Move to Timeline Controller
                NSLog("\nLogin Successful With User \(user)")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
                
            }
            else {
                
                // Log Failure
                NSLog("\nLogin Unsuccessful\nError: \(error)")
                
            }
            
        
        }
    
    }
    
    // User Sign Up Feature
    @IBAction func onSignUp(sender: AnyObject) {
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            if (success) {
                
                // Log user creation, Move to Timeline Controller
                NSLog("\nCreated a user with Sign Up")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
                
            }
                
            else {
                
                // Log creation failure
                NSLog("\nUser Creation from Sign Up Failed\nError: \(error?.localizedDescription)")
            
            }

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
