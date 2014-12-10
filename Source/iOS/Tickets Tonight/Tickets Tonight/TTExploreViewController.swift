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
        self.swipeableView = ZLSwipeableView(frame: self.view.frame)
        self.swipeableView.dataSource = self
        self.swipeableView.delegate = self
        self.view.addSubview(self.swipeableView)
        
        var query = PFQuery(className: kTTEventKey)
        query.orderByDescending(kTTEventDateObjectKey)
        query.cachePolicy = kPFCachePolicyCacheElseNetwork;
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            if error == nil {
                self.objects = results as? Array<PFObject>
            }
        }
    }
    
    // MARK: - Action
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
