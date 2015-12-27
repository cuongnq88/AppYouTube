//
//  Parser.swift
//  AppYouTuBe
//
//  Created by nguyen quoc cuong on 12/27/15.
//  Copyright © 2015 nguyen quoc cuong. All rights reserved.
//

import UIKit

class Parser {
    
    static func parserYoutubeFromJson(json: NSDictionary) -> [YouTube]?{
        var result = [YouTube]()
        if let items = json["items"] as? NSArray{
            for item in items {
                let youtube = YouTube()
                if let id = item["id"] as? NSDictionary {
                    youtube.videoId = id["videoId"] as? String
                }
                if let snippet = item["snippet"] as? NSDictionary {
                    youtube.title = snippet["title"] as? String
                    youtube.description = snippet["description"] as? String
                    if let thumbnails = snippet["thumbnails"] as? NSDictionary {
                        if let defaultUrl = thumbnails["default"] as? NSDictionary {
                            youtube.thumbnail = defaultUrl["url"] as? String
                        }
                    }
                }
                result.append(youtube)
            }
        }
        return result
    }
    
}
