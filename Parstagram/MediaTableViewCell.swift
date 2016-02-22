//
//  MediaTableViewCell.swift
//  Parstagram
//
//  Created by Alex Clark on 2/21/16.
//  Copyright © 2016 R. Alex Clark. All rights reserved.
//

import UIKit

class MediaTableViewCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
