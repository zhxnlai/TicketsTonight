//
//  TTFeedViewController.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 11/13/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

let cellIdentifier = "cell"
class TTFeedTableViewController: TTEventsTableViewController {
    var sectionSortedKeys: Array<String> = Array<String>()
    var sections: Dictionary<String, Array<PFObject>> = Dictionary<String, Array<PFObject>>()
    override init(style: UITableViewStyle) {
        super.init(style: style)
        title = "Feed"
        pullToRefreshEnabled = true
        objectsPerPage = 15
        paginationEnabled = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionSortedKeys[section]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[sectionSortedKeys[section]]!.count
    }
    
    // MARK: - delegate
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
//        
//    }
    
    // MARK: - Parse.com Logic
    override func queryForTable() -> PFQuery! {
        var query = PFQuery(className: parseClassName)
        
        if ((PFUser.currentUser()) == nil) {
            query.limit = 0;
            return query;
        }
        
        //        query.whereKey(, equalTo: pId)
        query.orderByDescending(kTTEventDateObjectKey)
        query.cachePolicy = kPFCachePolicyCacheElseNetwork;
        
        return query
    }
    
    // MARK: - Data
    override func objectsDidLoad(error: NSError!) {
        super.objectsDidLoad(error)
        
        sections.removeAll()
        for anyObject in objects {
            if let object:PFObject = anyObject as? PFObject {
                var date = object[kTTEventDateKey] as String
                
                var array = sections[date]
                if var actualArray = array {
                    actualArray.append(object)
                    sections[date] = actualArray
                } else {
                    sections[date] = [object]
                }
            }
        }
        
        sectionSortedKeys = Array<String>(sections.keys).sorted({ (A, B) -> Bool in
            return A>B
        })
        tableView.reloadData()
    }
    
    override func objectAtIndexPath(indexPath: NSIndexPath!) -> PFObject! {
        return sections[sectionSortedKeys[indexPath.section]]![indexPath.row]
    }
    

    
}
