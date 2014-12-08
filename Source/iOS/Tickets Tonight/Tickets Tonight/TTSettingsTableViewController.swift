//
//  TTSettingsViewController.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 11/13/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

class TTSettingsTableViewController: UITableViewController {
    
    // MARK: Cells
    enum TTSettingsTableViewControllerSection: Int {
        case Account, Location, Logout, Count
        
        enum AccountRow: Int {
            case Username, Count
        }
        
        
        enum LocationRow: Int {
            case Location, Count
        }
        
        enum LogoutRow: Int {
            case Logout, Count
        }
        
        static let sectionTitles = [
            Account: "Account", Location: "Location", Logout: "Logout"]
        
        static let sectionCount = [Account: AccountRow.Count.rawValue, Location: LocationRow.Count.rawValue, Logout: LogoutRow.Count.rawValue, ];
        
        func sectionHeaderTitle() -> String {
            if let sectionTitle = TTSettingsTableViewControllerSection.sectionTitles[self] {
                return sectionTitle
            } else {
                return "section"
            }
        }
        
        func sectionRowCount() -> Int {
            if let sectionCount = TTSettingsTableViewControllerSection.sectionCount[self] {
                return sectionCount
            } else {
                return 0
            }
        }

        
    }
    
    override func viewDidLoad() {
        //        self.tableView.registerClass(TTEventTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return TTSettingsTableViewControllerSection.Count.rawValue
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TTSettingsTableViewControllerSection(rawValue:section)!.sectionRowCount()
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TTSettingsTableViewControllerSection(rawValue:section)!.sectionHeaderTitle()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellIdentifier = String(format: "s%li-r%li", indexPath.section, indexPath.row)
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        if cell==nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
        }
        
        switch TTSettingsTableViewControllerSection(rawValue:indexPath.section)! {
        case .Account:
            switch TTSettingsTableViewControllerSection.AccountRow(rawValue: indexPath.row)! {
            case .Username:
                cell!.textLabel!.text = "Username"
            default:
                cell!.textLabel!.text = "Account"
            }
        case .Location:
            switch TTSettingsTableViewControllerSection.LocationRow(rawValue: indexPath.row)! {
            case .Location:
                cell!.textLabel!.text = "Location"
            default:
                cell!.textLabel!.text = "Location"
            }
        case .Logout:
            switch TTSettingsTableViewControllerSection.LogoutRow(rawValue: indexPath.row)! {
            case .Logout:
                cell!.textLabel!.text = "Logout"
            default:
                cell!.textLabel!.text = "Logout"
            }
        default:
            cell!.textLabel!.text = "N/A"
        }

        
        return cell!
    }

}
