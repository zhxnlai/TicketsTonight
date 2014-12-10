//
//  TTEventViewController.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 12/7/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit
import MapKit

class TTEventViewController: UITableViewController {
    
    var backgroundImageView:UIImageView!
    
    var mapView:MKMapView!
    let mapViewHeight = CGFloat(250)
    
    var object:PFObject? {
        didSet {
            
            if let event = object {
                
                title = event[kTTEventNameKey] as? String
                
                let width = self.view.frame.size.width
                var headerView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: width*2/3.0))
                headerView.contentMode = .ScaleAspectFill
                headerView.clipsToBounds = true
                
                
                let artistId = event[kTTEventPrimaryArtistKey] as String
                findArtistById(artistId.toInt()!, { (object, error) -> () in
                    if let artist = object {
                        let venueImgUrl = artist[kTTArtistImageURLKey] as String
                        headerView.sd_setImageWithURL(NSURL(string: venueImgUrl), placeholderImage: placeholderImg)
                        self.backgroundImageView.sd_setImageWithURL(NSURL(string: venueImgUrl), placeholderImage: placeholderImg, completed: { (image, error, cacheType, url) -> Void in
                            self.backgroundImageView.image = image.blurredImageWithRadius(80, iterations: 2, tintColor: UIColor.blackColor())
                        })
                    }
                })

                tableView.tableHeaderView = headerView
                tableView.reloadData()

            }
        }
    }
    
    override init() {
        super.init(style: .Grouped)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Here you can init your properties
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewStyle) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        tableView.separatorStyle = .None;
        super.viewDidLoad()
        
        backgroundImageView = UIImageView(frame: view.bounds)
//        backgroundBlurView = FXBlurView(frame: view.bounds)
//        backgroundBlurView.tintColor = UIColor.blackColor()
//        backgroundBlurView.blurRadius = 80
//        backgroundBlurView.dynamic = false
//        backgroundImageView.addSubview(backgroundBlurView)
        tableView.backgroundView = backgroundImageView
        
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
            case Location, Map, Count
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
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(55)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath == NSIndexPath(forRow: TTEventTableViewControllerSection.LocationRow.Map.rawValue, inSection: TTEventTableViewControllerSection.Location.rawValue) {
            return mapViewHeight
        }
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
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellIdentifier = String(format: "s%li-r%li", indexPath.section, indexPath.row)
        var cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        if cell==nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
        }
        
        cell.textLabel?.textColor = UIColor.flatCloudsColor()
        cell.detailTextLabel?.textColor = UIColor.flatCloudsColor()
        
        cell.accessoryType = .DisclosureIndicator
        cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        switch TTEventTableViewControllerSection(rawValue:indexPath.section)! {
        case .Follow:
            switch TTEventTableViewControllerSection.FollowRow(rawValue: indexPath.row)! {
            case .Follow:
                cell.textLabel!.text = "Follow Event"
                var followingSwitch = UISwitch()
                cell.accessoryView = followingSwitch
            default:
                cell.textLabel!.text = "Follow"
            }
        case .Artists:
            switch TTEventTableViewControllerSection.ArtistsRow(rawValue: indexPath.row)! {
            case .Artists:
                if let event = object {
                    let artistId = event[kTTEventPrimaryArtistKey] as String
                    findArtistById(artistId.toInt()!, { (object, error) -> () in
                        if let artist = object {
                            cell.textLabel!.text = artist[kTTArtistNameKey] as? String
//                            self.imageURL = artist[kTTArtistImageURLKey] as? String
                        }
                    })

                }

                cell.textLabel!.text = "Artists"
            default:
                cell.textLabel!.text = "Artists"
            }
        case .Tickets:
            switch TTEventTableViewControllerSection.TicketsRow(rawValue: indexPath.row)! {
            case .Tickets:
                if let event = object {
                    if let priceRange = event[kTTEventPriceRangeKey] as? String {
                        cell.detailTextLabel?.text = "USD \(priceRange)"
                    }
                }
                cell.textLabel!.text = "Ticketmaster"
            default:
                cell.textLabel!.text = "Tickets"
            }

        case .Location:
            switch TTEventTableViewControllerSection.LocationRow(rawValue: indexPath.row)! {
            case .Location:
                if let event = object {
                    let venueId = event[kTTEventVenueIdKey] as String
                    findVenueById(venueId.toInt()!, { (object, error) -> () in
                        if let venue = object {
                            // set location
                            cell.textLabel!.text = venue[kTTVenueNameKey] as? String
                        }
                    })
                    
                }

                cell.textLabel!.text = "Location"
            case .Map:
                if let event = object {
                    let venueId = event[kTTEventVenueIdKey] as String
                    findVenueById(venueId.toInt()!, { (object, error) -> () in
                        if let venue = object {
                            // set location
//                            cell.textLabel!.text = venue[kTTVenueNameKey] as? String
                            cell.accessoryType = .None
                            
                            if self.mapView == nil {
                                self.mapView = MKMapView(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), self.mapViewHeight))
                                self.mapView.scrollEnabled = false
                                cell.addSubview(self.mapView)
                            }
                            
                            let location = "\(venue[kTTVenueStreetKey]), \(venue[kTTVenueCityKey]), \(venue[kTTVenueStateKey]), \(venue[kTTVenueZipCodeKey])"
                            var geoCoder = CLGeocoder()
                            geoCoder.geocodeAddressString(location, completionHandler: { (placemarks, error) -> Void in
                                if error == nil {
                                    if let clplacemarks:Array<CLPlacemark> = placemarks as? Array<CLPlacemark> {
                                        let mkplacemark = MKPlacemark(placemark: clplacemarks.first)
                                        
                                        var region = self.mapView.region
                                        region.center = mkplacemark.location.coordinate
                                        region.span = spanForDistanceAtCoordinate(region.center, 10, 10)
                                        self.mapView.setRegion(region, animated: false)
                                        self.mapView.addAnnotation(mkplacemark)
                                    }
                                }
                            })

                        }
                    })
                    
                }
                
//                cell.textLabel!.text = "Location"
            default:
                cell.textLabel!.text = "Location"
            }
        default:
            cell.textLabel!.text = "N/A"
        }
        
        
        return cell
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
            if let event = object {
                let purchaseUrl = event[kTTEventPurchaseRequestURLKey] as? String
                var webView = SVWebViewController(address: purchaseUrl)
                self.navigationController?.pushViewController(webView, animated: true)

            }
        case .Location:
            if indexPath.row == 0 {
                if let event = object {
                    let venueId = event[kTTEventVenueIdKey] as String
                    findVenueById(venueId.toInt()!, { (object, error) -> () in
                        if let venue = object {
                            let venueUrl = venue[kTTVenueURLKey] as? String
                            var webView = SVWebViewController(address: venueUrl)
                            self.navigationController?.pushViewController(webView, animated: true)
                        }
                    })
                    
                }
            }
            return
        default:
            return
        }
    }

    

}
