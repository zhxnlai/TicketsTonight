//
//  TTImageTableViewCell.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 12/7/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

class TTImageTableViewCell: PFTableViewCell {
    
    let VTotal = 90
    let HMargin = 12
    let VMargin = 20
    
    let HInnerMargin = 20
    let VInnerMargin = 15

    let ImageWidth = 70
    //CGRectMake(HLMargin, (VTotal-ImageWidth)/2, ImageWidth, ImageWidth);
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .DisclosureIndicator
        
        self.imageView.layer.cornerRadius = CGFloat(ImageWidth/2);
        self.imageView.layer.masksToBounds = true;
        self.imageView.layer.backgroundColor = UIColor.clearColor().CGColor;
        self.imageView.contentMode = .ScaleAspectFill
        self.imageView.clipsToBounds = true
        
        
        self.backgroundColor = kTTBackgroundColor
        self.textLabel?.textColor = kTTPrimaryTextColor
        self.textLabel?.font = UIFont.boldSystemFontOfSize(18)
        self.detailTextLabel?.textColor = kTTSecondaryTextColor
        self.detailTextLabel?.font = UIFont.systemFontOfSize(16)
//        self.backgroundColor = UIColor.flatCloudsColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        let imageViewOldRightEdge = imageView.frame.origin.x+imageView.frame.size.width;
        imageView.frame = CGRect(x: HMargin, y: (VTotal-ImageWidth)/2, width: ImageWidth, height: ImageWidth)
        let imageViewNewRightEdge = imageView.frame.origin.x+imageView.frame.size.width;

        let deltaX = imageViewNewRightEdge-imageViewOldRightEdge
        textLabel?.center = CGPoint(x: textLabel!.center.x+deltaX, y: textLabel!.center.y)
        detailTextLabel?.center = CGPoint(x: detailTextLabel!.center.x+deltaX, y: detailTextLabel!.center.y)
//        textLabel.frame = CGRectMake(imageViewRightEdge+HInnerLMargin, YTextLabel, 140, VTextLabel);
//        self.subtitleLabel.frame = CGRectMake(imageViewRightEdge+HInnerLMargin, 12+66-20, 140, 90-66);

    }
    
    var imageURL: String? {
        didSet {
            if let url = imageURL {
                self.imageView!.sd_setImageWithURL(NSURL(string: url), placeholderImage: SVGKImage(named: "PlaceholderImageSVG").UIImage)
            }
        }
    }

    class func heightForCell() -> CGFloat {return CGFloat(90)}

}
