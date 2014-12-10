//
//  TTUtils.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 12/8/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import Foundation
import MapKit
import Darwin

func findArtistById(Id:Int, withBlock: (PFObject?, NSError?) -> ()) {
    var query = PFQuery(className: kTTArtistKey)
    query.limit = 1;
    query.whereKey(kTTArtistIDKey, equalTo: Id)
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    query.getFirstObjectInBackgroundWithBlock({ (object, error) -> Void in
        withBlock(object, error)

    })

}

func findVenueById(Id:Int, withBlock: (PFObject?, NSError?) -> ()) {
    var query = PFQuery(className: kTTVenueKey)
    query.limit = 1;
    query.whereKey(kTTVenueIDKey, equalTo: String(Id))
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    query.getFirstObjectInBackgroundWithBlock({ (object, error) -> Void in
        withBlock(object, error)
        
    })
    
}

let placeholderImg:UIImage = SVGKImage(named: "PlaceholderImageSVG").UIImage

func spanForDistanceAtCoordinate(coord: CLLocationCoordinate2D, xDistance: Double, yDistance: Double) -> MKCoordinateSpan {
    let kilometersPerDegree = Double(111)
    let xDegree = CLLocationDegrees(xDistance/kilometersPerDegree)
    let yDegree = CLLocationDegrees(yDistance/(kilometersPerDegree * cos(coord.latitude * M_PI / 180.0)))
    return MKCoordinateSpan(latitudeDelta: xDegree, longitudeDelta: yDegree)
}