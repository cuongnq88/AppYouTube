//
//  PlayVideoViewController.swift
//  AppYouTuBe
//
//  Created by nguyen quoc cuong on 1/10/16.
//  Copyright © 2016 nguyen quoc cuong. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class PlayVideoViewController: UIViewController {

    @IBOutlet weak var playerView: YTPlayerView!
    
    var videoID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.loadWithVideoId(videoID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
