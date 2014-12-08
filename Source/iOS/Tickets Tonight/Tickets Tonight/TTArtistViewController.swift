//
//  TTArtistViewController.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 11/13/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

class TTArtistViewController: TTEventsTableViewController {
    var object:PFObject? {
        didSet {
            if let artist = object {
                title = artist[kTTArtistNameKey] as? String
                
                
                let width = self.view.frame.size.width
                var headerView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: width))
                
                let artistImgUrl = artist[kTTArtistImageURLKey] as String
                headerView.sd_setImageWithURL(NSURL(string: artistImgUrl), placeholderImage: SVGKImage(named: "PlaceholderImageSVG").UIImage)
                tableView.tableHeaderView = headerView

                
                self.loadObjects()
            }
        }
    }

    override init(style: UITableViewStyle) {
        super.init(style: style)
        title = "Aritist"
        pullToRefreshEnabled = true
        objectsPerPage = 15
        paginationEnabled = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Parse.com Logic
    override func queryForTable() -> PFQuery! {
        var query = PFQuery(className: parseClassName)
        
        if ((PFUser.currentUser()) == nil || object == nil) {
            query.limit = 0;
            return query;
        }
        
        if let artist = object {
            var artistId:Int = artist[kTTArtistIDKey] as Int;
            query.whereKey(kTTEventPrimaryArtistKey, equalTo: String(artistId))
            query.orderByAscending(kTTEventDateKey)
            query.cachePolicy = kPFCachePolicyCacheThenNetwork;
            
            println("parseClassName: \(parseClassName) object \(artist) id: \(artistId)")
            
        }
        return query
    }
    
}
