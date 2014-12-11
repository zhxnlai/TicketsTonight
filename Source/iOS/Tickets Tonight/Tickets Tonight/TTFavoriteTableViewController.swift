//
//  TTFavoriteTableViewController.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 12/7/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

class TTFavoriteTableViewController: TTArtistsTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = kTTBackgroundColor

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: Selector("searchButtonAction:"))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action
    func searchButtonAction(barButtonItem: UIBarButtonItem) {
        var searchVC = TTSearchArtistsTableViewController(style: .Plain)
        navigationController?.pushViewController(searchVC, animated: true);
    }
    
    override func tableView(tableView: UITableView!, cellForNextPageAtIndexPath indexPath: NSIndexPath!) -> PFTableViewCell! {
        var cell = super.tableView(tableView, cellForNextPageAtIndexPath: indexPath)
        cell.backgroundColor = kTTBackgroundColor
        cell.textLabel?.textColor = kTTPrimaryTextColor
        return cell
    }
    
    // MARK: - Parse.com Logic
    override func queryForTable() -> PFQuery! {
        var query = PFQuery(className: parseClassName)
        
        if ((PFUser.currentUser()) == nil) {
            query.limit = 0;
            return query;
        }
        
        let following = PFUser.currentUser().objectForKey(kTTUserFavoriteArtistsKey) as? Array<PFObject>
        if let actualFollowing = following {
            var objectIds = actualFollowing.reduce(Array<String>(), combine: { (acc, object) -> Array<String> in
                var array = acc
                array.append(object.objectId)
                return array
            })
            query.whereKey("objectId", containedIn: objectIds)
            query.orderByDescending(kTTArtistNameKey)
            query.cachePolicy = kPFCachePolicyCacheElseNetwork;
        } else {
            query.limit = 0;
            query.whereKey("objectId", containedIn: [])

            return query;
        }
        
        return query
    }

}
