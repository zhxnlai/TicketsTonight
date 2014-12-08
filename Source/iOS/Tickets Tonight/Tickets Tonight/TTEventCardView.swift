//
//  TTEventView.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 11/13/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

let kEventPerformanceNameKey = "PerformanceName"
let kEventVenueImageURLKey = "VenueImageURL"
let kEventArtistNameKey = "ArtistName"
let kEventArtistImageURLKey = "ArtistImageURL"

class TTEventCardView: TTCardView {
    // in the row: name, date, time (reviews)
    // venue: name, image, address (street, city, state, zip code)
    // artist: name, category
    
    @IBOutlet weak var VenueImageView: UIImageView!
    @IBOutlet weak var artistImageView: UIImageView!
    
    @IBOutlet weak var performanceNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var event:Dictionary<String,String>? {
//        get {
//            self.event
//        }
        didSet {
//            self.event = newEvent
            self.updateView(self.event!)
        }
    }
    
    func updateView(event:Dictionary<String,String>) {
        
        if let venueImageURL = event[kEventVenueImageURLKey] {
            self.VenueImageView.sd_setImageWithURL(NSURL(string: venueImageURL), placeholderImage: SVGKImage(named: "PlaceholderImageSVG").UIImage)
        }
        
        if let artistImageURL = event[kEventArtistImageURLKey] {
            self.artistImageView.sd_setImageWithURL(NSURL(string: artistImageURL), placeholderImage: SVGKImage(named: "PlaceholderImageSVG").UIImage)
        }
        
        if let performanceName = event[kEventPerformanceNameKey] {
            self.performanceNameLabel.text = performanceName
        }
        if let artistName = event[kEventArtistNameKey] {
            self.artistNameLabel.text = artistName
        }

        self.artistImageView.contentMode = .ScaleAspectFill
        self.artistImageView.clipsToBounds = true
        self.VenueImageView.contentMode = .ScaleAspectFill
        self.VenueImageView.clipsToBounds = true

    }
    
}
