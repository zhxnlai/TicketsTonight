//
//  TTConstants.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 11/17/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import Foundation

let kTTFeedObjectIDKey = "ID"

// MARK: - Artist
let kTTArtistCategoryKey = "ArtistCategory" // ID attribute
let kTTArtistCategoryIdKey = "ArtistCategoryId"
let kTTArtistNameKey = "ArtistName"
let kTTArtistURLKey = "ArtistURL"
let kTTArtistImageURLKey = "ArtistImageURL"
// how is it
let kTTArtistStarsKey = "Stars"
let kTTArtistStarReviewCountKey = "StarReviewCount"

// MARK: - Category
let kTTCategoryNameKey = "CategoryName"
let kTTCategoryParentIdKey = "ParentID"

// MARK: - Venue
let kTTVenueNameKey = "VenueName"
let kTTVenueNumberKey = "VenueNumber"
let kTTVenueURLKey = "VenueURL"
let kTTVenueImageURLKey = "VenueImageURL"
// address
let kTTVenueCityKey = "City"
let kTTVenueStateKey = "State"
let kTTVenueStreetKey = "Street"
let kTTVenueZipCodeKey = "ZipCode"
// there are some more
// ...

// MARK: - Event
let kTTEventNameKey = "PerformanceName"
// who
let kTTEventArtistIdsKey = "ArtistIDs" // array
let kTTEventCategoryIdKey = "CategoryID"
// when
let kTTEventDateKey = "EventDate" // date and time
let kTTEventStatusKey = "EventStatus" // number
let kTTEventOnsaleDateKey = "OnsaleDate"
let kTTEventPresaleDateKey = "PresaleDate"
// where
let kTTEventVenueIdKey = "VenueID"
// how much
let kTTEventPriceRangeKey = "PriceRange"
let kTTEventPurchaseRequestURLKey = "PurchaseRequestURL"
let kTTEventPromoterIdKey = "PromoterID"
// how is it
let kTTEventStarsKey = "Stars"
let kTTEventStarReviewCountKey = "StarReviewCount"
