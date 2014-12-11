//
//  TTCategoryViewController.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 12/7/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

class TTCategoryViewController: PFQueryTableViewController {
    
    var parentId: Int?;
    
    init() {
        super.init(style: .Plain, className: kTTCategoryKey)
        title = "Category"
        pullToRefreshEnabled = true
        paginationEnabled = false

    }
    override init!(style: UITableViewStyle, className: String!) {
        fatalError("init(coder:) has not been implemented")
    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count;
    }
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!, object: PFObject!) -> PFTableViewCell! {
        var cell:PFTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? PFTableViewCell
        if cell==nil {
            cell = PFTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
        }
        
        
        cell!.textLabel!.text = object![kTTCategoryNameKey] as? String
        return cell!

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var object = objects[indexPath.row] as PFObject
        
        if let pId = object[kTTCategoryParentIdKey] as? Int {
            // leaf nodes since category only has two levels
            var categoryArtistsViewController = TTCategoryArtistsTableViewController(style: .Plain)
            categoryArtistsViewController.object = object
            navigationController!.pushViewController(categoryArtistsViewController, animated: true);

        } else {
            // level 1 since category only has two levels
            var categoryViewController = TTCategoryViewController();
            categoryViewController.parentId = object[kTTCategoryIDKey] as? Int
            navigationController!.pushViewController(categoryViewController, animated: true);
        }
    }
    
    // MARK: - Parse.com Logic
    override func queryForTable() -> PFQuery! {
        var query = PFQuery(className: parseClassName)

        if ((PFUser.currentUser()) == nil) {
            query.limit = 0;
            return query;
        }
        
        if let pId = parentId {
            query.whereKey(kTTCategoryParentIdKey, equalTo: pId)
        } else {
            query.whereKeyDoesNotExist(kTTCategoryParentIdKey)
        }
        query.orderByAscending(kTTCategoryNameKey)
        query.cachePolicy = kPFCachePolicyCacheElseNetwork;

        return query
    }

}
