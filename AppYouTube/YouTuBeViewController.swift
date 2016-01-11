//
//  YouTuBeViewController.swift
//  AppYouTuBe
//
//  Created by nguyen quoc cuong on 12/21/15.
//  Copyright © 2015 nguyen quoc cuong. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class YouTuBeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    let YOUR_API_KEY = "AIzaSyDeg1l2DploCTEIOJmRUO5a7_d9CidzwjM"
    
    let YOUR_HOST_YOUTUBE = "https://www.youtube.com/watch?v="
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var tableData: [YouTube] = []
    
    private var isSearch: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "YouTuBeCell", bundle: nil), forCellReuseIdentifier: "YouTuBeCell")
        self.retrieveDataFromYoutube("")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - TableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("YouTuBeCell", forIndexPath: indexPath) as! YouTuBeCell
        let youtube = tableData[indexPath.row]
        cell.loadImageWidthString(youtube.thumbnail!)
        cell.titleLabel.text = youtube.title
        cell.descriptionLabel.text = youtube.description
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let youtube = tableData[indexPath.row]
//        if let url: NSURL = NSURL(string: YOUR_HOST_YOUTUBE + (youtube.videoId)!) {
//            UIApplication.sharedApplication().openURL(url)
//        }
        self.performSegueWithIdentifier("PlayYoutube", sender: youtube)
    }
    
    // MARK: - Get data from yotube
    
    func retrieveDataFromYoutube(query: String) -> Void {
        self.isSearch = false
        let http = HTTPCommunication()
        let parameters = ["part":"snippet","maxResults":"20","q":query,"key":YOUR_API_KEY]
        let url = http.makeUrlWidthString("https://www.googleapis.com/youtube/v3/search", parameters: parameters)
        
        http.retrieveURL(url!) { (response: NSData?) -> Void in
            if let data = response {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                    if let youtubeList = Parser.parserYoutubeFromJson(json){
                        self.tableData.removeAll()
                        self.tableData.appendContentsOf(youtubeList)
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Error parser data")
                }
                
            }
        }
    }
    
    // MARK: - SearchBar
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("text = \(searchBar.text)")
        if isSearch {
            if let query = searchBar.text {
                retrieveDataFromYoutube(query)
            }
        }
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText = \(searchText)")
        isSearch = true
        if searchText.isEmpty {
            retrieveDataFromYoutube("")
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PlayYoutube" {
            if let destination = segue.destinationViewController as? PlayVideoViewController {
                if let youtube = sender as? YouTube {
                    print(youtube)
                    destination.videoID = youtube.videoId
                }
            }
            
        }
    }
    
}

























