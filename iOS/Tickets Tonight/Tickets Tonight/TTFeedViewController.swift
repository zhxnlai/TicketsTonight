//
//  TTFeedViewController.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 11/13/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

let cellIdentifier = "cell"
class TTFeedViewController: UITableViewController {
    
    override func viewDidLoad() {
//        self.tableView.registerClass(TTEventTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:TTEventTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? TTEventTableViewCell
        if cell==nil {
            cell = TTEventTableViewCell(style: UITableViewCellStyle.Subtitle,
                reuseIdentifier: cellIdentifier)
        }

        
        cell!.event = events[indexPath.row]
        return cell!
    }
}
