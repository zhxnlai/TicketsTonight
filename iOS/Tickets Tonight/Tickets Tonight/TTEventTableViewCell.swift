//
//  TTEventTableViewCell.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 11/13/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

class TTEventTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var event:Dictionary<String,String>? {
        didSet {
            self.updateView(self.event!)
        }
    }
    
    func updateView(event:Dictionary<String,String>) {
        
        if let venueImageURL = event[kEventVenueImageURLKey] {
            self.imageView.sd_setImageWithURL(NSURL(string: venueImageURL), placeholderImage: SVGKImage(named: "PlaceholderImageSVG").UIImage)
        }
        
//        if let artistImageURL = event[kEventArtistImageURLKey] {
//            self.artistImageView.sd_setImageWithURL(NSURL(string: artistImageURL), placeholderImage: SVGKImage(named: "PlaceholderImageSVG").UIImage)
//        }
        
        if let performanceName = event[kEventPerformanceNameKey] {
            self.textLabel.text = performanceName
        }
        if let artistName = event[kEventArtistNameKey] {
            self.detailTextLabel?.text = artistName
        }
        
        
    }

}
