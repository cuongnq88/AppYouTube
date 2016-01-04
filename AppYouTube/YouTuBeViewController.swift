//
//  YouTuBeViewController.swift
//  AppYouTuBe
//
//  Created by nguyen quoc cuong on 12/21/15.
//  Copyright © 2015 nguyen quoc cuong. All rights reserved.
//

import UIKit

class YouTuBeViewController: UIViewController, UITableViewDataSource ,UITableViewDelegate{
    
    let YOUR_API_KEY = "AIzaSyDeg1l2DploCTEIOJmRUO5a7_d9CidzwjM"
    
    @IBOutlet weak var tableView: UITableView!
    
    private var tableData: [YouTube] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "YouTuBeCell", bundle: nil), forCellReuseIdentifier: "YouTuBeCell")
        self.retrieveDataFromYoutube()
        
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
    
    // MARK: - Get data from yotube
    
    func retrieveDataFromYoutube() -> Void {
        let http = HTTPCommunication()
        let parameters = ["part":"snippet","maxResults":"20","q":"ball","key":YOUR_API_KEY]
        let url = http.makeUrlWidthString("https://www.googleapis.com/youtube/v3/search", parameters: parameters)

        http.retrieveURL(url!) { (response: NSData?) -> Void in
            if let data = response {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                    if let youtubeList = Parser.parserYoutubeFromJson(json){
                        self.tableData.appendContentsOf(youtubeList)
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Error parser data")
                }

            }
        }
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
