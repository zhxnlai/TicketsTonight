//
//  TTLocationFeedTableViewController.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 12/11/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

class TTLocationFeedTableViewController: TTFeedTableViewController {
   
    override init(style: UITableViewStyle) {
        super.init(style: style)
        title = "Los Angeles"

        pullToRefreshEnabled = true
        //        objectsPerPage = 15
        paginationEnabled = false
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Parse.com Logic
    override func queryForTable() -> PFQuery! {
        var query = PFQuery(className: parseClassName)
        
        if ((PFUser.currentUser()) == nil) {
            query.limit = 0;
            return query;
        }
        
        var venueQuery = PFQuery(className: kTTVenueKey)
        venueQuery.whereKey(kTTVenueCityKey, equalTo: "Los Angeles")
        venueQuery.cachePolicy = kPFCachePolicyCacheElseNetwork;
        query.whereKey(kTTEventVenueIdKey, matchesKey: kTTVenueIDKey, inQuery: venueQuery)
        
        query.orderByDescending(kTTEventDateObjectKey)
        query.cachePolicy = kPFCachePolicyCacheElseNetwork;
        
        return query
    }
    
}
