//
//  TTCompactEventTableViewCell.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 12/10/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

class TTArtistEventTableViewCell: PFTableViewCell {
    let HMargin = 12
    let ImageWidth = 70
    let VTotal = 50
    
    var monthDayLabel:UILabel!
    var yearLabel:UILabel!

    var object: PFObject? {
        didSet {
            if let event = object {
                if let dateObject = event[kTTEventDateObjectKey] as? NSDate {
                    //                let dateComponents = NSCalendar.currentCalendar().components(.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit , fromDate: dateObject)
                    //                let date = NSCalendar.currentCalendar().dateFromComponents(dateComponents)!
                    //                let yearDate = NSCalendar.currentCalendar().dateFromComponents(yearComponents)!
                    let dateTexts = NSDateFormatter.localizedStringFromDate(dateObject, dateStyle: .MediumStyle, timeStyle: .NoStyle).componentsSeparatedByString(", ")
                    self.monthDayLabel!.text = dateTexts[0]
                    self.yearLabel!.text = dateTexts[1]

                }

                self.textLabel!.text = event[kTTEventNameKey] as? String

                let venueId = event[kTTEventVenueIdKey] as? String
                let venueIdInt = venueId?.toInt()
                
                if let actualId = venueIdInt {
                    findVenueById(actualId, { (object, error) -> () in
                        if let venue = object {
                            let venueText = "\(venue[kTTVenueCityKey]!), \(venue[kTTVenueStateKey]!)"
                            self.detailTextLabel?.text = venueText
                        }
                    })
                }
                
                self.setNeedsLayout()
                self.layoutIfNeeded()
                
            }
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .DisclosureIndicator
        
        self.imageView.layer.cornerRadius = CGFloat(ImageWidth/2);
        self.imageView.layer.masksToBounds = true;
        self.imageView.layer.backgroundColor = UIColor.clearColor().CGColor;
        self.imageView.contentMode = .ScaleAspectFill
        self.imageView.clipsToBounds = true
        
        
        self.textLabel?.textColor = kTTPrimaryTextColor
        self.textLabel?.font = UIFont.boldSystemFontOfSize(18)
        self.detailTextLabel?.textColor = kTTPrimaryTextColor
        self.detailTextLabel?.font = UIFont.systemFontOfSize(16)
        
        self.monthDayLabel = UILabel()
        self.monthDayLabel?.textColor = kTTPrimaryTextColor
        self.monthDayLabel?.font = UIFont.boldSystemFontOfSize(18)
        self.addSubview(self.monthDayLabel)
        
        self.yearLabel = UILabel()
        self.yearLabel?.textColor = kTTPrimaryTextColor
        self.yearLabel?.font = UIFont.systemFontOfSize(16)
        self.addSubview(self.yearLabel)

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.monthDayLabel?.frame = self.textLabel!.frame
        self.yearLabel?.frame = self.detailTextLabel!.frame
        
//        let imageViewOldRightEdge = imageView.frame.origin.x+imageView.frame.size.width;
//        imageView.frame = CGRect(x: HMargin, y: (VTotal-ImageWidth)/2, width: ImageWidth, height: ImageWidth)
//        let imageViewNewRightEdge = imageView.frame.origin.x+imageView.frame.size.width;
        
        let deltaX = CGFloat(ImageWidth)
        textLabel?.center = CGPoint(x: textLabel!.center.x+deltaX, y: textLabel!.center.y)
        detailTextLabel?.center = CGPoint(x: detailTextLabel!.center.x+deltaX, y: detailTextLabel!.center.y)
        //        textLabel.frame = CGRectMake(imageViewRightEdge+HInnerLMargin, YTextLabel, 140, VTextLabel);
        //        self.subtitleLabel.frame = CGRectMake(imageViewRightEdge+HInnerLMargin, 12+66-20, 140, 90-66);
        
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
