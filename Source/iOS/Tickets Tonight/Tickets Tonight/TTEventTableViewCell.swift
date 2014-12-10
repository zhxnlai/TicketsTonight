//
//  TTEventTableViewCell.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 11/13/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

class TTEventTableViewCell: TTImageTableViewCell {

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var object: PFObject? {
        didSet {
            if let event = object {
                self.textLabel!.text = event[kTTEventNameKey] as? String
                let artistId = event[kTTEventPrimaryArtistKey] as? String
                let artistIdInt = artistId?.toInt()
                let venueId = event[kTTEventVenueIdKey] as? String
                let venueIdInt = venueId?.toInt()
                
                if let actualId = venueIdInt {
                    findVenueById(actualId, { (object, error) -> () in
                        if let venue = object {
                            self.imageURL = venue[kTTVenueImageURLKey] as? String
                        }
                    })
                }
                if let actualId = artistIdInt {
                    findArtistById(actualId, { (object, error) -> () in
                        if let artist = object {
                            self.detailTextLabel!.text = artist[kTTArtistNameKey] as? String
                            //                        self.imageURL = artist[kTTArtistImageURLKey] as? String
                        }
                    })
                }
                
                self.setNeedsLayout()
                self.layoutIfNeeded()

            }
        }
    }
    
}
