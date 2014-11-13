//
//  TTExploreViewController.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 11/13/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

var events = [
    [   kEventPerformanceNameKey:"Million Dollar Quartet",
        kEventVenueImageURLKey:"http://media.ticketmaster.com/tmimages/TM_GenVenueImg_BW.jpg",
        kEventArtistNameKey:"Tim Allen",
        kEventArtistImageURLKey:"http://media.ticketmaster.com/dbimages/52819a",
    ],
    [   kEventPerformanceNameKey:"Eye Candy Saturdays At the Atlanta Museum Bar",
        kEventVenueImageURLKey:"http://media.ticketmaster.com/dbimages/7002v.jpg",
        kEventArtistNameKey:"The Flying Karamazov Brothers",
        kEventArtistImageURLKey:"http://media.ticketmaster.com/dbimages/76011a.jpg",
    ],
    [   kEventPerformanceNameKey:"Mary Poppins (New York, NY)",
        kEventVenueImageURLKey:"http://media.ticketmaster.com/dbimages/7196v.jpg",
        kEventArtistNameKey:"Mary Poppins",
        kEventArtistImageURLKey:"http://media.ticketmaster.com/dbimages/65401a.jpg",
    ],
    [   kEventPerformanceNameKey:"The Global Warming Tour Featuring Aerosmith And Cheap Trick",
        kEventVenueImageURLKey:"http://media.ticketmaster.com/dbimages/7613v.jpg",
        kEventArtistNameKey:"Aerosmith",
        kEventArtistImageURLKey:"http://media.ticketmaster.com/dbimages/105900a.jpg",
    ],
    [   kEventPerformanceNameKey:"Guns N&apos; Roses - Appetite for Democracy",
        kEventVenueImageURLKey:"http://media.ticketmaster.com/dbimages/sheratoncentre_tor_131272_4Z.gif",
        kEventArtistNameKey:"Junior Brown",
        kEventArtistImageURLKey:"http://media.ticketmaster.com/dbimages/38374a.jpg",
    ],
    [   kEventPerformanceNameKey:"Celine Dion",
        kEventVenueImageURLKey:"http://media.ticketmaster.com/dbimages/havelock_tor_131283_4Z.gif",
        kEventArtistNameKey:"Celine Dion",
        kEventArtistImageURLKey:"http://media.ticketmaster.com/dbimages/122726a.jpg",
    ],
    
    
]

extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
}


class TTExploreViewController: UIViewController, ZLSwipeableViewDelegate, ZLSwipeableViewDataSource  {
    var swipeableView:ZLSwipeableView!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        self.swipeableView = ZLSwipeableView(frame: self.view.frame)
        self.swipeableView.dataSource = self
        self.swipeableView.delegate = self
        self.view.addSubview(self.swipeableView)
    }
    func nextViewForSwipeableView(swipeableView: ZLSwipeableView!) -> UIView! {

        self.eventIndex = self.eventIndex%events.count
        
        var view = TTEventCardView.loadFromNibNamed("eventCardView") as TTEventCardView
        //(frame: CGRect(x: 0, y: 0, width: 250, height: 400))
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 500)
        view.cardColor = UIColor.whiteColor()
        view.setTranslatesAutoresizingMaskIntoConstraints(true)
        //            view.frame = CGRect(x: 0, y: 0, width: 250, height: 400)
        view.event = events[eventIndex]
        //        view.autoresizingMask = .None
        //        view.autoresizesSubviews = false
        //        view.contentMode = .ScaleToFill
        //        view.setTranslatesAutoresizingMaskIntoConstraints(true)
        //        view.removeConstraints(Array(view.constraints()))
        //        var timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("view"), userInfo: nil, repeats: true)
        
        self.eventIndex++
        return view

    }
    

    func swipeableView(swipeableView: ZLSwipeableView!, didStartSwipingView view: UIView!, atLocation location: CGPoint) {
        
//        removeAutoLayout(view)
        
//        view.removeConstraints(Array(view.constraints()))
//        for subview in view.subviews {
//            subview.removeConstraints(Array(subview.constraints()))
//
//        }

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
    var eventIndex:Int = 0
}
