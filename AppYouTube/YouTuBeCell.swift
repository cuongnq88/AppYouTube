//
//  YouTuBeCell.swift
//  AppYouTuBe
//
//  Created by nguyen quoc cuong on 12/21/15.
//  Copyright © 2015 nguyen quoc cuong. All rights reserved.
//

import UIKit

class YouTuBeCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadImageWidthString(url: String) -> Void {
        
        if let imageUrl = NSURL(string: url) {
            let request = NSURLRequest(URL: imageUrl)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if error == nil {
                    self.thumbnail.image = UIImage(data: data!)
                }
            })
            
        }
    }

}
