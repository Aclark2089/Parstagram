//
//  ImageCaptureViewController.swift
//  Parstagram
//
//  Created by Alex Clark on 2/21/16.
//  Copyright © 2016 R. Alex Clark. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD

let userUploadedPhotoNotification = "User Uploaded Photo"

class ImageCaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var uploadPhotoButton: UIButton!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var chosenImageView: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    
    let media = UserMedia()
    let ivc = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ivc.delegate = self
        ivc.allowsEditing = true
        
        // Hide the photoview and the caption text field on load
        chosenImageView.hidden = true
        captionField.hidden = true
        submitButton.hidden = true

        // Do any additional set up after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Press upload
    @IBAction func onUpload(sender: AnyObject) {
        
        // Bring up the photo lib
        ivc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        // Enable the hidden media fields
        showImagePickerController()
    }

    // Press of take new photo
    @IBAction func onTakePhoto(sender: AnyObject) {
        
        // Bring up the camera
        ivc.sourceType = UIImagePickerControllerSourceType.Camera
        
        showImagePickerController()
    }
    
    @IBAction func onSubmit(sender: AnyObject) {

        SVProgressHUD.show()
        
        // Make sure we have an image and caption
        if (captionField.text != nil && chosenImageView.image != nil) {
            
            media.postNewImage(chosenImageView.image!, withCaption: captionField.text, withCompletion: {(success: Bool, error: NSError?) ->
                Void in
                // Check if we have an error
                if let error = error {
                    
                    // Log the given error
                    NSLog("Unable to upload image\nError: \(error)\n")
                    
                    // Shut down the progress wheel
                    SVProgressHUD.dismiss()
                    
                    // Alert the user to what happened
                    let alert = UIAlertController(title: "Error Uploading Image", message: "", preferredStyle: .Alert)
                    let dismissAction = UIAlertAction(title: "OK", style: .Default) { (action) in }
                    alert.addAction(dismissAction)
                    self.presentViewController(alert, animated: true) {}
                    
                }
                // Image was able to be uploaded!
                else {
                    
                    // Log
                    NSLog("Success on image post\n")
                    
                    // Dismiss progress wheel
                    SVProgressHUD.dismiss()
                    
                    // Go back home
                    NSNotificationCenter.defaultCenter().postNotificationName(userUploadedPhotoNotification, object: nil)
                    
                }
                
            })
        }
        // No caption found
        else if (captionField.text == nil) {
            
            // Log
            NSLog("Image did not include a caption\n")
            
            // Shut down the progress wheel
            SVProgressHUD.dismiss()
            
            // Alert the user to what happened
            let alert = UIAlertController(title: "No Caption", message: "Please include a caption!", preferredStyle: .Alert)
            let dismissAction = UIAlertAction(title: "OK", style: .Default) { (action) in }
            alert.addAction(dismissAction)
            self.presentViewController(alert, animated: true) {}
        
        }
        // No image chosen
        else if (chosenImageView.image == nil) {
            
            // Log
            NSLog("No image chosen for upload\n")
            
            // Shut down the progress wheel
            SVProgressHUD.dismiss()
            
            // Alert the user to what happened
            let alert = UIAlertController(title: "No Image Chosen", message: "Please pick an image!", preferredStyle: .Alert)
            let dismissAction = UIAlertAction(title: "OK", style: .Default) { (action) in }
            alert.addAction(dismissAction)
            self.presentViewController(alert, animated: true) {}
            
        }
        // No image or caption chosen
        else {
            
            // Shut down progress wheel regardless
            SVProgressHUD.dismiss()
            
        }
    }
    
    // Show the ivc
    func showImagePickerController() {
        self.presentViewController(ivc, animated: true, completion: nil)
    }
    
    // Setup the image picker controller
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            
            // Bring up everything we need for picker
            chosenImageView.hidden = false
            captionField.hidden = false
            submitButton.hidden = false
        
            
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            // Set image
            chosenImageView.image = editedImage
            
            // Dismiss controller
            dismissViewControllerAnimated(true, completion: nil)
            
    }
    

}
