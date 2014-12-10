//
//  TTCompactEventTableViewCell.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 12/10/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

class TTArtistEventTableViewCell: PFTableViewCell {
    var object: PFObject? {
        didSet {
            if let event = object {
                self.textLabel!.text = event[kTTEventNameKey] as? String
//                let artistId = event[kTTEventPrimaryArtistKey] as? String
//                let artistIdInt = artistId?.toInt()
                let venueId = event[kTTEventVenueIdKey] as? String
                let venueIdInt = venueId?.toInt()
                
                if let actualId = venueIdInt {
                    findVenueById(actualId, { (object, error) -> () in
                        if let venue = object {
                            let venueText = "\(venue[kTTVenueCityKey]!), \(venue[kTTVenueStateKey]!)"

                            self.detailTextLabel?.text = venueText

//                            self.imageURL = venue[kTTVenueImageURLKey] as? String
                        }
                    })
                }
//                if let actualId = artistIdInt {
//                    findArtistById(actualId, { (object, error) -> () in
//                        if let artist = object {
//                            self.detailTextLabel!.text = artist[kTTArtistNameKey] as? String
//                            //                        self.imageURL = artist[kTTArtistImageURLKey] as? String
//                        }
//                    })
//                }
                
                self.setNeedsLayout()
                self.layoutIfNeeded()
                
            }
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .DisclosureIndicator
        
//        self.imageView.layer.cornerRadius = CGFloat(ImageWidth/2);
//        self.imageView.layer.masksToBounds = true;
//        self.imageView.layer.backgroundColor = UIColor.clearColor().CGColor;
//        self.imageView.contentMode = .ScaleAspectFill
//        self.imageView.clipsToBounds = true
        
        
//        self.backgroundColor = kTTBackgroundColor
        self.textLabel?.textColor = kTTPrimaryTextColor
        self.textLabel?.font = UIFont.boldSystemFontOfSize(18)
        self.detailTextLabel?.textColor = kTTPrimaryTextColor
        self.detailTextLabel?.font = UIFont.systemFontOfSize(16)
        //        self.backgroundColor = UIColor.flatCloudsColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
