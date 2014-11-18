//
//  TTXMLFeedParser.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 11/17/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import Cocoa

class TTXMLFeedParser: NSObject, NSXMLParserDelegate {
    var currentElementValue:String?
    
    var parser: NSXMLParser?

    
    init(stream:NSInputStream) {
        super.init()

        parser = NSXMLParser(stream:stream)
        parser.delegate = self
    }
    
    
    
}
