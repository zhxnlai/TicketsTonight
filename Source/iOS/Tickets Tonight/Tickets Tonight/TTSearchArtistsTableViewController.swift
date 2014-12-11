//
//  TTSearchTableViewController.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 12/10/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

class TTSearchArtistsTableViewController: TTArtistsTableViewController, UISearchBarDelegate {
    var searchBar:UISearchBar = UISearchBar()
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        pullToRefreshEnabled = true
        objectsPerPage = 6
        paginationEnabled = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = kTTBackgroundColor

        searchBar.placeholder = "Search for Artists"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        
        searchBar.becomeFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.loadObjects()
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
        
        if ((PFUser.currentUser()) == nil || searchBar.text == nil || searchBar.text == "") {
            query.limit = 0;
            return query;
        }
        
        query.whereKey(kTTArtistNameKey, containsString:searchBar.text)
        query.orderByAscending(kTTArtistNameKey)
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
        
        
        return query
    }

}
