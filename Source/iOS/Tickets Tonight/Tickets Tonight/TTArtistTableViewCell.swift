//
//  TTArtistTableViewCell.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 12/7/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

class TTArtistTableViewCell: TTImageTableViewCell {
    var object: PFObject? {
        didSet {
            if let artist = object {
                self.textLabel!.text = artist[kTTArtistNameKey] as? String
                self.imageURL = artist[kTTArtistImageURLKey] as? String
                
                self.setNeedsLayout()
                self.layoutIfNeeded()
            }
        }
    }
    
    
}
