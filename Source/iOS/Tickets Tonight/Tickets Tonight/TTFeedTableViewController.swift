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
    
    // TODO: my favorite, nearme, tracking
    
    var sectionSortedKeys: Array<NSDate> = Array<NSDate>()
    var sections: Dictionary<NSDate, Array<PFObject>> = Dictionary<NSDate, Array<PFObject>>()
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
        tableView.backgroundColor = kTTBackgroundColor
        
        
    }

    // MARK: - data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var count = sections.count
        if paginationEnabled {
            count += 1
        }
        return count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section>=sections.count {return 1}
        return sections[sectionSortedKeys[section]]!.count
    }
        
    override func tableView(tableView: UITableView!, cellForNextPageAtIndexPath indexPath: NSIndexPath!) -> PFTableViewCell! {
        var cell = super.tableView(tableView, cellForNextPageAtIndexPath: indexPath)
        cell.backgroundColor = kTTBackgroundColor
        cell.textLabel?.textColor = kTTPrimaryTextColor
        return cell
    }

    // MARK: - delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        if indexPath.section>=sections.count {
            loadNextPage()
        }
    }
    
    
    
    
    // MARK: - header
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(40)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section>=sections.count {return "More"}
        return NSDateFormatter.localizedStringFromDate(sectionSortedKeys[section], dateStyle: .FullStyle, timeStyle: .NoStyle)
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: CGRectGetWidth(view.frame), height: self.tableView(tableView, heightForHeaderInSection: section)))
        label.backgroundColor = kTTBackgroundColor
        label.text = "   \(self.tableView(tableView, titleForHeaderInSection: section)!)"
        label.textColor = kTTPrimaryTextColor
        label.font = UIFont.boldSystemFontOfSize(16)
        return label
    }
    
    
    
    // MARK: - Parse.com Logic
    override func queryForTable() -> PFQuery! {
        var query = PFQuery(className: parseClassName)
        
        if ((PFUser.currentUser()) == nil) {
            query.limit = 0;
            return query;
        }
        
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
                let dateObject = object[kTTEventDateObjectKey] as NSDate
                let dateComponents = NSCalendar.currentCalendar().components(.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit | .WeekdayCalendarUnit , fromDate: dateObject)
                let date = NSCalendar.currentCalendar().dateFromComponents(dateComponents)!
                //NSDateFormatter.localizedStringFromDate(dateObject, dateStyle: .MediumStyle, timeStyle: .NoStyle)

                var array = sections[date]
                if var actualArray = array {
                    actualArray.append(object)
                    sections[date] = actualArray
                } else {
                    sections[date] = [object]
                }
            }
        }
        
        sectionSortedKeys = Array<NSDate>(sections.keys).sorted({ (A, B) -> Bool in
            return A.laterDate(B) == A
        })
        tableView.reloadData()
    }
    
    override func objectAtIndexPath(indexPath: NSIndexPath!) -> PFObject! {
        if indexPath.section>=sections.count {return nil}
        return sections[sectionSortedKeys[indexPath.section]]![indexPath.row]
    }
    
    func _indexPathForPaginationCell() -> NSIndexPath {
        return NSIndexPath(forRow: 0, inSection: sections.count)
    }

    
}
