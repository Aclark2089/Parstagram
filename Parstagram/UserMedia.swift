//
//  UserMedia.swift
//  Parstagram
//
//  Created by Alex Clark on 2/21/16.
//  Copyright © 2016 R. Alex Clark. All rights reserved.
//

import UIKit
import Parse

// Class to handle holding media retrieved from Parse Server for user home timeline
class UserMedia: NSObject {
    
    
    // Function to handle user posting of new image to the timeline
    func postNewImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        
        // Setup the media object we will be posting using Parse
        let media = PFObject(className: "UserMedia")
        
        // We need to get the column type
        media["media"] =  getPFFileUsingImage(image)
        
        // User who created media, i.e. current user
        media["author"] = PFUser.currentUser()
        
        // Caption for the media passed w/ function
        media["caption"] = caption
        
        // Counts for number of likes and comments on the object
        media["commentCount"] = 0
        media["likeCount"] = 0
        
        
        // Save the media object to the server after we have set the fields
        media.saveInBackgroundWithBlock(completion)
        
    }
    
    
    func getPFFileUsingImage(image: UIImage?) -> PFFile? {
        
        // Make absolutely sure we can work with the passed image
        if let image = image {
            // Attempt to gather data from the image we have using UIImagePNGRepresentation(), and pass it back if we get it
            if let data = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: data)
            }
        }
        
        // If we get here, we had an issue with the image we passed and are not going to get a PFFile return object, log and send nil
        NSLog("Error: Unable to return PFFile in getPFFileUsingImage function\n")
        return nil
    }
}
