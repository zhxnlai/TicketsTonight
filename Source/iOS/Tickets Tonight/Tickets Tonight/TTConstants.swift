//
//  TTConstants.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 11/17/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import Foundation

let kTTBarColor = UIColor(red: 0.145, green: 0.157, blue: 0.176, alpha: 1)
let kTTBackgroundColor = UIColor(red: 0.176, green: 0.192, blue: 0.216, alpha: 1)
let kTTPrimaryTextColor = UIColor(red: 0.863, green: 0.863, blue: 0.863, alpha: 1)
let kTTSecondaryTextColor = UIColor(red: 0.529, green: 0.553, blue: 0.588, alpha: 1)


// MARK: - Parse
let kTTUserRunCountKey = "RunCount"
let kTTUserFavoriteArtistsKey = "FavoriteArtists"
let kTTUserFavoriteArtistIdsKey = "FavoriteArtistIds"
let kTTUserFollowingEventsKey = "FollowingEvents"
let kTTUserFollowingEventIdsKey = "FollowingEventIds"


// MARK: - Affinity
let kTTAffinityKey = "aff"
let kTTAffinityArtistNameKey = "ArtistName"
let kTTAffinityRecArtistsKey = "RecArtists"

let kTTAffinityRecArtistIDKey = "RecId"
let kTTAffinityRecArtistNameKey = "RecName"
let kTTAffinityRecArtistScoreKey = "RecVal"


let kTTFeedObjectIDKey = "ID"

// MARK: - Artist
let kTTArtistKey = "Artists"
let kTTArtistCategoryKey = "Category" // ID attribute
let kTTArtistIDKey = "ID"
let kTTArtistNameKey = "Name"
let kTTArtistURLKey = "URL"
let kTTArtistImageURLKey = "ImageURL"
// how is it
let kTTArtistStarsKey = "Stars"
let kTTArtistStarReviewCountKey = "StarReviewCount"

// MARK: - Category
let kTTCategoryKey = "Categories"
let kTTCategoryIDKey = "ID"
let kTTCategoryNameKey = "Name"
let kTTCategoryParentIdKey = "ParentID"

// MARK: - Venue
let kTTVenueKey = "Venues"
let kTTVenueNameKey = "VenueName"
let kTTVenueIDKey = "ID"
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
let kTTEventKey = "EventsPricePoints"
let kTTEventNameKey = "PerformanceName"
// who
let kTTEventPrimaryArtistKey = "ArtistA"
let kTTEventSecondaryArtist1Key = "ArtistB"
let kTTEventSecondaryArtist2Key = "ArtistC"
let kTTEventCategoryKey = "Category"
// when
let kTTEventDateKey = "EventDate" // date string
let kTTEventTimeKey = "EventTime" // time string
let kTTEventDateObjectKey = "EventDateObject" // date and time
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
