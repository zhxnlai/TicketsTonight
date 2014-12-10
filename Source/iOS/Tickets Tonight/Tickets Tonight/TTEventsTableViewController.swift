//
//  TTEventsTableViewController.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 12/8/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

class TTEventsTableViewController: PFQueryTableViewController {

    init(style: UITableViewStyle) {
        super.init(style: style, className: kTTEventKey)
//        title = ""
//        pullToRefreshEnabled = true
//        paginationEnabled = false
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        tableView.separatorStyle = .None;
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!, object: PFObject!) -> PFTableViewCell! {
        var cell:TTEventTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? TTEventTableViewCell
        if cell==nil {
            cell = TTEventTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
        }
        
        cell!.object = object
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var object = self.objectAtIndexPath(indexPath)
        if let event = object {
            var eventViewController = TTEventViewController();
            eventViewController.object = event
            navigationController!.pushViewController(eventViewController, animated: true);
        }

    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return TTEventTableViewCell.heightForCell()
    }
    

    // MARK: - Parse.com Logic
    override func queryForTable() -> PFQuery! {
        fatalError("queryForTable() has not been implemented")
    }

}
