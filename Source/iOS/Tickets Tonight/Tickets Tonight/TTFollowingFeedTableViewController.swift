//
//  TTFollowingFeedTableViewController.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 12/10/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

class TTFollowingFeedTableViewController: TTFeedTableViewController {
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
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
        
        let following = PFUser.currentUser().objectForKey(kTTUserFollowingEventIdsKey) as? Array<String>
        if let actualFollowing = following {
            query.whereKey("objectId", containedIn: actualFollowing)
            query.orderByDescending(kTTEventDateObjectKey)
            query.cachePolicy = kPFCachePolicyCacheElseNetwork;
        } else {
            query.limit = 0;
            return query;
        }

        
        return query
    }
    
}
