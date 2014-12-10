//
//  TTImageTableViewCell.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 12/7/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

class TTImageTableViewCell: PFTableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var imageURL: String? {
        didSet {
            if let url = imageURL {
                self.imageView!.sd_setImageWithURL(NSURL(string: url), placeholderImage: SVGKImage(named: "PlaceholderImageSVG").UIImage)
            }
        }
    }

}
