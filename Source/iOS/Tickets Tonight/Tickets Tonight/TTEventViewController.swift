//
//  TTEventViewController.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 12/7/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

class TTEventViewController: UITableViewController {
    
    var object:PFObject? {
        didSet {
            
            if let event = object {
                let width = self.view.frame.size.width
                var headerView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: width))

                let venueId = event[kTTEventVenueIdKey] as String
                findVenueById(venueId.toInt()!, { (object, error) -> () in
                    if let venue = object {
                        let venueImgUrl = venue[kTTVenueImageURLKey] as String
                        headerView.sd_setImageWithURL(NSURL(string: venueImgUrl), placeholderImage: SVGKImage(named: "PlaceholderImageSVG").UIImage)
                    }
                })
                tableView.tableHeaderView = headerView
                tableView.reloadData()

            }
        }
    }
    
//    init(Style: UITableViewStyle) {
//        super.init(style: .Grouped)
//    }
//
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Cells
    enum TTEventTableViewControllerSection: Int {
        case Follow, Artists, Tickets, Location, Count
        
        enum FollowRow: Int {
            case Follow, Count
        }
        
        enum ArtistsRow: Int {
            case Artists, Count
        }
        
        enum TicketsRow: Int {
            case Tickets, Count
        }

        enum LocationRow: Int {
            case Location, Count
        }
        
        static let sectionTitles = [
            Follow: "Follow", Artists: "Artists", Tickets: "Tickets", Location: "Location"]
        
        static let sectionCount = [Follow: FollowRow.Count.rawValue, Artists: ArtistsRow.Count.rawValue, Tickets: TicketsRow.Count.rawValue, Location: LocationRow.Count.rawValue ];
        
        func sectionHeaderTitle() -> String {
            if let sectionTitle = TTEventTableViewControllerSection.sectionTitles[self] {
                return sectionTitle
            } else {
                return "section"
            }
        }
        
        func sectionRowCount() -> Int {
            if let sectionCount = TTEventTableViewControllerSection.sectionCount[self] {
                return sectionCount
            } else {
                return 0
            }
        }
        
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return TTEventTableViewControllerSection.Count.rawValue
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TTEventTableViewControllerSection(rawValue:section)!.sectionRowCount()
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TTEventTableViewControllerSection(rawValue:section)!.sectionHeaderTitle()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellIdentifier = String(format: "s%li-r%li", indexPath.section, indexPath.row)
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        if cell==nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
        }
        
        switch TTEventTableViewControllerSection(rawValue:indexPath.section)! {
        case .Follow:
            switch TTEventTableViewControllerSection.FollowRow(rawValue: indexPath.row)! {
            case .Follow:
                cell!.textLabel!.text = "Follow Event"
                var followingSwitch = UISwitch()
                cell?.accessoryView = followingSwitch
            default:
                cell!.textLabel!.text = "Follow"
            }
        case .Artists:
            switch TTEventTableViewControllerSection.ArtistsRow(rawValue: indexPath.row)! {
            case .Artists:
                if let event = object {
                    let artistId = event[kTTEventPrimaryArtistKey] as String
                    findArtistById(artistId.toInt()!, { (object, error) -> () in
                        if let artist = object {
                            cell?.textLabel!.text = artist[kTTArtistNameKey] as? String
//                            self.imageURL = artist[kTTArtistImageURLKey] as? String
                        }
                    })

                }

                cell!.textLabel!.text = "Artists"
            default:
                cell!.textLabel!.text = "Artists"
            }
        case .Tickets:
            switch TTEventTableViewControllerSection.ArtistsRow(rawValue: indexPath.row)! {
            case .Artists:
                cell!.textLabel!.text = "Tickets"
            default:
                cell!.textLabel!.text = "Tickets"
            }

        case .Location:
            switch TTEventTableViewControllerSection.LocationRow(rawValue: indexPath.row)! {
            case .Location:
                cell!.textLabel!.text = "Location"
            default:
                cell!.textLabel!.text = "Location"
            }
        default:
            cell!.textLabel!.text = "N/A"
        }
        
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch TTEventTableViewControllerSection(rawValue:indexPath.section)! {
        case .Follow:
            return
        case .Artists:
            if let event = object {
                let artistId = event[kTTEventPrimaryArtistKey] as? String
                let artistIdInt = artistId!.toInt()!
                
                findArtistById(artistIdInt, { (object, error) -> () in
                    if let artist = object {
                        var artistVC = TTArtistViewController(style: .Grouped)
                        artistVC.object = artist
                        self.navigationController?.pushViewController(artistVC, animated: true)
                    }
                })
                
            }
        case .Tickets:
            return
        case .Location:
            return
        default:
            return
        }
    }

    

}
