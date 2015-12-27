//
//  HTTPCommunication.swift
//  AppYouTuBe
//
//  Created by nguyen quoc cuong on 12/21/15.
//  Copyright © 2015 nguyen quoc cuong. All rights reserved.
//

import UIKit

class HTTPCommunication: NSObject, NSURLSessionDownloadDelegate {
    
    typealias CompletionHandler = (response: NSData?) -> Void
    
    var completionHandler: CompletionHandler?
    
    func retrieveURL(url: NSURL, completionHandler: CompletionHandler) -> Void {
        self.completionHandler = completionHandler
        let request = NSURLRequest(URL: url)
        let conf = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: conf, delegate: self, delegateQueue: nil)
        let task = session.downloadTaskWithRequest(request)
        task.resume()
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        let data = NSData(contentsOfURL:location)
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if let handler = self.completionHandler {
                handler(response: data)
            }
        }
    }
    
    //makeTextWritingDirectionLeftToRight
    
    func makeUrlWidthString(host: String, parameters: [String: String]) -> NSURL? {
        var url: String = host + "?"
        for(pramKey, paramValue) in parameters {
            url = url + pramKey + "=" + paramValue + "&"
        }
        url = url.substringWithRange(Range<String.Index>(start: url.startIndex, end: url.endIndex.advancedBy(-1)))
        return NSURL(string: url)
    }
    
}
