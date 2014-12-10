//
//  TTCategoryArtistsTableViewController.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 12/7/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

class TTCategoryArtistsTableViewController: TTArtistsTableViewController {
    
    var object: PFObject? {
        didSet {
            if let category = object {
                title = category[kTTCategoryNameKey] as? String
                self.loadObjects()
            }
        }
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        title = "Aritists"
        pullToRefreshEnabled = true
        objectsPerPage = 15
        paginationEnabled = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - tableviewdatadelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    // MARK: - Parse.com Logic
    override func queryForTable() -> PFQuery! {
        var query = PFQuery(className: parseClassName)
        
        if ((PFUser.currentUser()) == nil || object == nil) {
            query.limit = 0;
            return query;
        }
        
        if let category = object {
            var categoryId:Int = category[kTTCategoryIDKey] as Int;
            query.whereKey(kTTArtistCategoryKey, equalTo: categoryId)
            query.orderByAscending(kTTArtistNameKey)
            query.cachePolicy = kPFCachePolicyCacheThenNetwork;

            println("parseClassName: \(parseClassName) object \(category) id: \(categoryId)")

        }
        return query
    }
}
