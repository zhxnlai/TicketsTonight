//
//  TTCardView.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 11/13/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

class TTCardView: UIView {
    var cardColor:UIColor?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.backgroundColor = UIColor.clearColor();
        
        // Color Declarations
        var shadowColor2 = UIColor(red: 0.209, green: 0.209, blue: 0.209, alpha: 1)
        
        // Shadow Declarations
        var shadow = shadowColor2.colorWithAlphaComponent( 0.73)
        var shadowOffset = CGSizeMake(3.1/2.0, -0.1/2.0)
        var shadowBlurRadius = 12/2.0
        self.layer.shadowColor = shadow.CGColor
        self.layer.shadowOpacity = 0.73
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = CGFloat(shadowBlurRadius)
        self.layer.shouldRasterize = true
        
        
        
    }
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        super.drawRect(rect)
        
        let frameWidth = rect.size.width;
        let frameHeight = rect.size.height;
        let cornerRadius = CGFloat(10);
        
        //// General Declarations
        var context = UIGraphicsGetCurrentContext();
        
        CGContextSaveGState(context);
        CGContextBeginTransparencyLayer(context, nil);
        
        let rect = CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight)
        var rectPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        cardColor?.setFill()
        rectPath.fill()
        
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);

    }


}
