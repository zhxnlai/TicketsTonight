//
//  TTUtils.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 12/8/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import Foundation

func findArtistById(Id:Int, withBlock: (PFObject?, NSError?) -> ()) {
    var query = PFQuery(className: kTTArtistKey)
    query.limit = 1;
    query.whereKey(kTTArtistIDKey, equalTo: Id)
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    query.getFirstObjectInBackgroundWithBlock({ (object, error) -> Void in
        withBlock(object, error)

    })

}

func findVenueById(Id:Int, withBlock: (PFObject?, NSError?) -> ()) {
    var query = PFQuery(className: kTTVenueKey)
    query.limit = 1;
    query.whereKey(kTTVenueIDKey, equalTo: String(Id))
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    query.getFirstObjectInBackgroundWithBlock({ (object, error) -> Void in
        withBlock(object, error)
        
    })
    
}