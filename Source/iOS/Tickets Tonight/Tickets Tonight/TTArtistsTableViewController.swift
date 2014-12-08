//
//  TTArtistsTableViewController.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 12/7/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

class TTArtistsTableViewController: PFQueryTableViewController {

    init(style: UITableViewStyle) {
        super.init(style: style, className: kTTArtistKey)
//        title = ""
//        pullToRefreshEnabled = true
//        paginationEnabled = false
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
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!, object: PFObject!) -> PFTableViewCell! {
        var cell:TTArtistTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? TTArtistTableViewCell
        if cell==nil {
            cell = TTArtistTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
        }
        
        cell!.object = object
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row >= objects.count {return}
        
        var artistViewController = TTArtistViewController(style: .Plain);
        var artist = objects[indexPath.row] as PFObject
        artistViewController.object = artist
        navigationController!.pushViewController(artistViewController, animated: true);

    }
    
    // MARK: - Parse.com Logic
    override func queryForTable() -> PFQuery! {
        fatalError("queryForTable() has not been implemented")
    }

}
