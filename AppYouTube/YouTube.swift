//
//  YouTube.swift
//  AppYouTuBe
//
//  Created by nguyen quoc cuong on 12/27/15.
//  Copyright © 2015 nguyen quoc cuong. All rights reserved.
//

import UIKit

class YouTube {
    
    // MARK: Properties
    
    var title: String?
    
    var videoId: String?
    
    var description: String?
    
    var thumbnail: String?
    
    // MARK: Initialization
    
    init() {
        
    }
    
    init(title: String, videoId: String, description: String, thumbnail: String) {
        // Initialize stored properties.
        self.title = title
        self.videoId = videoId
        self.description = description
        self.thumbnail = thumbnail;
    }
}
