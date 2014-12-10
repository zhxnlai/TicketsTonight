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
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: Selector("addButtonAction:"))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action
    func addButtonAction(barButtonItem: UIBarButtonItem) {
        var categoryViewController = TTCategoryViewController(style: .Plain, className: kTTCategoryKey);
        navigationController!.pushViewController(categoryViewController, animated: true);
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
        
        
//        query.whereKey(ktt, equalTo: categoryId)
        query.orderByAscending(kTTArtistNameKey)
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;

        
        return query
    }

}
