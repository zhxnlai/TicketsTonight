//
//  TTExploreViewController.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 11/13/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
}


class TTExploreViewController: UIViewController, ZLSwipeableViewDelegate, ZLSwipeableViewDataSource, TTEventCardViewDelegate  {
    var swipeableView:ZLSwipeableView!
    
    var affs:Array<PFObject>?
    // artist name -> rec event ids
    var affinityMap:Dictionary<String, Array<String>>?

    var objects:Array<PFObject>? {
        didSet {
            objectIndex = 0
            swipeableView.discardAllSwipeableViews()
            swipeableView.loadNextSwipeableViewsIfNeeded()
        }
    }
    var objectIndex = 0
    
    override func viewDidLoad() {
        self.view.backgroundColor = kTTBackgroundColor
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: Selector("searchButtonAction:"))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: Selector("refreshButtonAction:"))
        
        self.swipeableView = ZLSwipeableView(frame: self.view.frame)
        self.swipeableView.dataSource = self
        self.swipeableView.delegate = self
        self.view.addSubview(self.swipeableView)
        
        self.refreshButtonAction(nil)
    }
    
    // MARK: - Action
    func refreshButtonAction(barButtonItem: UIBarButtonItem!) {
        // artists -> names[] -> recArtists -> rectArtistsId: Array<Int> -> to string -> eventWhere(PrimaryArtist In ArtistsIdStringArray) -> exclude followed
        
        let following = PFUser.currentUser().objectForKey(kTTUserFavoriteArtistsKey) as? Array<PFObject>
        if let actualFollowing = following {
            var objectIds = actualFollowing.reduce(Array<String>(), combine: { (acc, object) -> Array<String> in
                var array = acc; array.append(object.objectId); return array
            })
            var artistQuery = PFQuery(className: kTTArtistKey)
            artistQuery.whereKey("objectId", containedIn: objectIds)
            //            artistQuery.orderByDescending(kTTArtistNameKey)
            artistQuery.cachePolicy = kPFCachePolicyCacheElseNetwork;
            
            artistQuery.findObjectsInBackgroundWithBlock { (results, error) -> Void in
                if error == nil {
                    if var artists = results as? Array<PFObject> {
                        var names = artists.reduce(Array<String>(), combine: { (acc, object) -> Array<String> in
                            var array = acc; array.append(object[kTTArtistNameKey] as String); return array
                        })
//                        println("favorite artists names: \(names)")
                        
                        var affinityQuery = PFQuery(className: kTTAffinityKey)
                        affinityQuery.whereKey(kTTAffinityArtistNameKey, containedIn: names)
                        affinityQuery.cachePolicy = kPFCachePolicyCacheElseNetwork;
                        affinityQuery.findObjectsInBackgroundWithBlock({ (results, error) -> Void in
                            if error == nil {
//                                println("affinityQuery results: \(results)")
                                
                                if let affs = results as? Array<PFObject> {
                                    self.affs = affs
                                    self.affinityMap = Dictionary<String, Array<String>>()
                                    
                                    var recArtistIds = affs.reduce(Array<String>(), combine: { (acc, object:PFObject) -> Array<String> in
                                        var array = acc;
//                                        println("1")
                                        if var recs = object[kTTAffinityRecArtistsKey] as? Array<NSDictionary> {
//                                            println("2: \(recs)")
                                            var subRecArtistIds = recs.reduce(Array<String>(), combine: { (acc, object:NSDictionary) -> Array<String> in
//                                                println("3 \(object)")
                                                var array = acc;
                                                if let idInt = object.objectForKey(kTTAffinityRecArtistIDKey) as? Int {
//                                                    println("4 \(idInt)")
                                                    array.append(String(idInt));
                                                }
                                                return array
                                            })
                                            let artistName = object[kTTAffinityArtistNameKey] as String
                                            self.affinityMap![artistName] = subRecArtistIds
                                            return array + subRecArtistIds
                                        }
                                        return array
                                    })
                                    
                                    println("map: \(self.affinityMap)")

                                    println("rec artists ids: \(recArtistIds)")
                                    
                                    var eventQuery = PFQuery(className: kTTEventKey)
                                    eventQuery.whereKey(kTTEventPrimaryArtistKey, containedIn: recArtistIds)
                                    eventQuery.whereKey("objectId", notContainedIn: PFUser.currentUser()[kTTUserFollowingEventIdsKey] as? Array<String>)
                                    eventQuery.orderByDescending(kTTEventDateObjectKey)
                                    eventQuery.cachePolicy = kPFCachePolicyCacheElseNetwork;
                                    eventQuery.findObjectsInBackgroundWithBlock { (results, error) -> Void in
                                        if error == nil {
                                            self.objects = results as? Array<PFObject>
                                        }
                                    }
                                }
                            }
                        })
                    }
                }
            }
            
        } else {
            // no favorite
            var query = PFQuery(className: kTTEventKey)
            query.orderByDescending(kTTEventDateObjectKey)
            query.cachePolicy = kPFCachePolicyCacheElseNetwork;
            query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
                if error == nil {
                    self.objects = results as? Array<PFObject>
                }
            }
        }
    }

    func searchButtonAction(barButtonItem: UIBarButtonItem) {
        var searchVC = TTSearchArtistsTableViewController(style: .Plain)
        navigationController?.pushViewController(searchVC, animated: true);
    }
    
    
    func eventCardDidTap(card: TTEventCardView) {
        if let event = card.object {
            var eventViewController = TTEventViewController();
            eventViewController.object = event
            navigationController!.pushViewController(eventViewController, animated: true);
            
        }
    }
        
    // MARK: - ZLSwipeableViewDataSource
    func nextViewForSwipeableView(swipeableView: ZLSwipeableView!) -> UIView! {

        if let events = objects {
            self.objectIndex = self.objectIndex%events.count
            
            var view = TTEventCardView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
            view.setTranslatesAutoresizingMaskIntoConstraints(true)
            view.object = events[objectIndex]
            
            var artistName = "Artist"
            if let actualMap = self.affinityMap {
                for (name, similarIds) in actualMap {
                    if let artistId = events[objectIndex][kTTEventPrimaryArtistKey] as? String {
                        if contains(similarIds, artistId) {
                            artistName = name
                        }
                    }
                }
            }
            view.similarArtistName = artistName

            self.objectIndex++
            view.delegate = self
            return view
        }
        return nil
    }
    

    func swipeableView(swipeableView: ZLSwipeableView!, didStartSwipingView view: UIView!, atLocation location: CGPoint) {
        view.setTranslatesAutoresizingMaskIntoConstraints(true);
    }
    
    func removeAutoLayout(view:UIView) {
        var superview = view.superview
        view.removeFromSuperview()
        view.setTranslatesAutoresizingMaskIntoConstraints(true)
        view.frame = CGRect(x: 0, y: 0, width: 250, height: 400)
        superview?.addSubview(view)
//        [self.benchmarkButton removeFromSuperview];
//        [self.benchmarkButton setTranslatesAutoresizingMaskIntoConstraints:YES];
//        [self.benchmarkButton setFrame:CGRectMake(20, self.benchmarkButton.frame.origin.y+40, 260, 30)];
//        [self.benchmarksView addSubview:self.benchmarkButton];

    }
}
