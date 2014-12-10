//
//  TTEventView.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 11/13/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

protocol TTEventCardViewDelegate: class {
    func eventCardDidTap(card: TTEventCardView)
}

class TTEventCardView: TTCardView {
    
    weak var delegate: TTEventCardViewDelegate?
    var tapGestureRecognizer: UITapGestureRecognizer!
    
    var artistImageView: UIImageView!
    var performanceNameLabel: UILabel!
    var artistNameLabel: UILabel!
    var timeLabel: UILabel!
    var locationLabel: UILabel!
    var similarArtistLabel: UILabel!

    var containerView: UIView!
    
    var object:PFObject? {
        didSet {
            if let event = object {
                self.performanceNameLabel?.text = event[kTTEventNameKey] as? String

                let venueId = event[kTTEventVenueIdKey] as String
                findVenueById(venueId.toInt()!, { (object, error) -> () in
                    if let venue = object {
                        // set location
                        let venueText = "\(venue[kTTVenueCityKey]!), \(venue[kTTVenueStateKey]!)"
                        self.locationLabel?.text = venueText
                    }
                })

                let artistId = event[kTTEventPrimaryArtistKey] as String
                findArtistById(artistId.toInt()!, { (object, error) -> () in
                    if let artist = object {
                        self.artistNameLabel?.text = artist[kTTArtistNameKey] as? String
                        let artistImgUrl = artist[kTTArtistImageURLKey] as? String
                        self.artistImageView.sd_setImageWithURL(NSURL(string: artistImgUrl!), placeholderImage: placeholderImg)
                    }
                })
                
                self.artistImageView.contentMode = .ScaleAspectFill
                self.artistImageView.clipsToBounds = true
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        containerView = UIView(frame: frame)
        self.addSubview(containerView)
        let cornerRadius = CGFloat(10);
        var maskFrame = frame
        maskFrame.size.height += cornerRadius
        var maskLayer = CALayer()
        maskLayer.cornerRadius = cornerRadius
        maskLayer.backgroundColor = UIColor.blackColor().CGColor
        maskLayer.frame = maskFrame
        containerView.layer.mask = maskLayer
        
        let artistImgHeight = CGRectGetHeight(frame)*2/3.0
        artistImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: CGRectGetWidth(frame), height: artistImgHeight))
        containerView.addSubview(artistImageView)
        
        let w = CGFloat(10.0)
//        artistNameLabel = UILabel(frame: CGRect(x: w, y: artistImgHeight, width: CGRectGetWidth(frame)-2*w, height: CGRectGetHeight(frame)-artistImgHeight))
//        containerView.addSubview(artistNameLabel)
        
        let labelHeight = (CGRectGetHeight(frame)-artistImgHeight)/3
        
        performanceNameLabel = UILabel(frame: CGRect(x: w, y: artistImgHeight, width: CGRectGetWidth(frame)-2*w, height: labelHeight))
        performanceNameLabel.textColor = kTTPrimaryTextColor
        performanceNameLabel.font = UIFont.systemFontOfSize(22)
        containerView.addSubview(performanceNameLabel)

        locationLabel = UILabel(frame: CGRect(x: w, y: artistImgHeight+labelHeight, width: CGRectGetWidth(frame)-2*w, height: labelHeight))
        locationLabel.font = UIFont.systemFontOfSize(22)
        locationLabel.textColor = kTTSecondaryTextColor
        containerView.addSubview(locationLabel)

        similarArtistLabel = UILabel(frame: CGRect(x: w, y: artistImgHeight+labelHeight*2, width: CGRectGetWidth(frame)-2*w, height: labelHeight))
        similarArtistLabel.textColor = kTTSecondaryTextColor
        similarArtistLabel.text = "Similar to "
        containerView.addSubview(similarArtistLabel)

        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("didTap:"))
        containerView.addGestureRecognizer(tapGestureRecognizer)
        
        
        cardColor = kTTBarColor
        artistNameLabel?.textColor = kTTPrimaryTextColor
        performanceNameLabel?.textColor = kTTPrimaryTextColor
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Action
    func didTap(recognizer:UITapGestureRecognizer) {
        self.delegate?.eventCardDidTap(self)
    }

    
}
