//
//  TTArtistViewController.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 11/13/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

class TTArtistViewController: TTEventsTableViewController {
    
    var headerView:UIImageView = UIImageView()
    var backgroundImageView:UIImageView = UIImageView()
    
    var object:PFObject? {
        didSet {
            if let artist = object {
                title = artist[kTTArtistNameKey] as? String
                
                let artistImgUrl = artist[kTTArtistImageURLKey] as String
                headerView.sd_setImageWithURL(NSURL(string: artistImgUrl), placeholderImage: SVGKImage(named: "PlaceholderImageSVG").UIImage)
                
                self.backgroundImageView.sd_setImageWithURL(NSURL(string: artistImgUrl), placeholderImage: placeholderImg, completed: { (image, error, cacheType, url) -> Void in
                    self.backgroundImageView.image = image.blurredImageWithRadius(80, iterations: 2, tintColor: UIColor.blackColor())
                })
                self.loadObjects()
            }
        }
    }

    override init(style: UITableViewStyle) {
        super.init(style: style)
        title = "Aritist"
        pullToRefreshEnabled = true
        objectsPerPage = 15
        paginationEnabled = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        tableView.separatorStyle = .None;
        super.viewDidLoad()
        
        backgroundImageView.frame = view.bounds
        tableView.backgroundView = backgroundImageView
        
        let width = self.view.frame.size.width
        headerView.contentMode = .ScaleAspectFill
        headerView.clipsToBounds = true
        self.tableView.setParallaxHeaderView(headerView, mode: .Fill, height: width*2/3.0)

    }
    
    // MARK: - Action
    func favoriteSwitchAction(aSwitch: UISwitch) {
        if let artist = object {
            if (aSwitch.on && PFUser.currentUser() != nil) {
                PFUser.currentUser().addUniqueObject(artist, forKey: kTTUserFavoriteArtistsKey)
                PFUser.currentUser().addUniqueObject(String(Int(artist.objectForKey(kTTArtistIDKey) as NSNumber)), forKey: kTTUserFavoriteArtistIdsKey)
                PFUser.currentUser().saveEventually()
            } else {
                PFUser.currentUser().removeObject(artist, forKey: kTTUserFavoriteArtistsKey)
                PFUser.currentUser().removeObject(String(Int(artist.objectForKey(kTTArtistIDKey) as NSNumber)), forKey: kTTUserFavoriteArtistIdsKey)
                PFUser.currentUser().saveEventually()
            }
        }
    }
    
    // MARK: - scrollview delegate
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        self.tableView.shouldPositionParallaxHeader()
    }
    
    // MARK: - data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {return 1}
        return super.tableView(tableView, numberOfRowsInSection: 0)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section==0 {
            return "Favorite"
        } else if section == 1 {
            return objects.count > 0 ? "Events" : "No Event"
        }
        return ""
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(55)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(50)
    }

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: CGRectGetWidth(view.frame), height: self.tableView(tableView, heightForHeaderInSection: section)))
        label.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        label.text = "   \(self.tableView(tableView, titleForHeaderInSection: section)!)"
        label.textColor = UIColor.flatCloudsColor()
        label.font = UIFont.boldSystemFontOfSize(18)
        return label
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!, object: PFObject!) -> PFTableViewCell! {
        if indexPath.section==0 {
            var cellIdentifier = String(format: "s%li-r%li", indexPath.section, indexPath.row)
            var cell:PFTableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? PFTableViewCell
            if cell==nil {
                cell = PFTableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
            }
            cell.textLabel?.text = "Favorite Artist"
            cell.textLabel?.textColor = kTTPrimaryTextColor
            cell.selectionStyle = .None
            
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
            
            var followingSwitch = UISwitch()
            followingSwitch.addTarget(self, action: Selector("favoriteSwitchAction:"), forControlEvents: .ValueChanged)
            cell.accessoryView = followingSwitch
            
            if let artist = self.object {
                let artistId: Int = Int(artist.objectForKey(kTTArtistIDKey) as NSNumber)
                let favorites = PFUser.currentUser().objectForKey(kTTUserFavoriteArtistIdsKey) as? Array<String>
//                println("user: \(PFUser.currentUser()) raw: \(PFUser.currentUser().objectForKey(kTTUserFavoriteArtistIdsKey) ) favorites: \(favorites) id: \(artistId)")

                if let acutalFavorites = favorites {
//                    println("favorites: \(acutalFavorites) id: \(artistId)")
                    
                    // artist IDs are Int in Artist, but are String in Event
                    followingSwitch.on = contains(acutalFavorites, String(artistId))
                }
            }

            return cell
        } else {
            var cell:TTArtistEventTableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? TTArtistEventTableViewCell
            if cell==nil {
                cell = TTArtistEventTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
            }
            cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)

            cell.object = object
            return cell
        }

    }

    
    override func tableView(tableView: UITableView!, cellForNextPageAtIndexPath indexPath: NSIndexPath!) -> PFTableViewCell! {
        var cell = super.tableView(tableView, cellForNextPageAtIndexPath: indexPath)
        cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        cell.textLabel?.textColor = kTTPrimaryTextColor
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        if indexPath.section==0 {

        } else {
            var object = self.objectAtIndexPath(indexPath)
            if let event = object {
                var eventViewController = TTEventViewController();
                eventViewController.object = event
                navigationController!.pushViewController(eventViewController, animated: true);
            }
//            super.tableView(tableView, didSelectRowAtIndexPath: NSIndexPath(forRow: indexPath.row, inSection: 0))
            if indexPath.row>=objects.count {
                loadNextPage()
            }
        }
    }
    
    override func objectAtIndexPath(indexPath: NSIndexPath!) -> PFObject! {
        if indexPath.section==0 {
            return nil
        } else {
            return super.objectAtIndexPath(NSIndexPath(forRow: indexPath.row, inSection: 0))
        }
    }
    
    func _indexPathForPaginationCell() -> NSIndexPath {
        return NSIndexPath(forRow: objects.count, inSection: 1)
    }

    
    // MARK: - Parse.com Logic
    override func queryForTable() -> PFQuery! {
        var query = PFQuery(className: parseClassName)
        
        if ((PFUser.currentUser()) == nil || object == nil) {
            query.limit = 0;
            return query;
        }
        
        if let artist = object {
            var artistId:Int = artist[kTTArtistIDKey] as Int;
            query.whereKey(kTTEventPrimaryArtistKey, equalTo: String(artistId))
            query.orderByAscending(kTTEventDateKey)
            query.cachePolicy = kPFCachePolicyCacheThenNetwork;
            
//            println("parseClassName: \(parseClassName) object \(artist) id: \(artistId)")
            
        }
        return query
    }
    
}
