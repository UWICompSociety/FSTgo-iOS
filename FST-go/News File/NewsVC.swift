//
//  NewsVC.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/20/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit

class NewsVC: UIViewController,UITableViewDelegate,UITableViewDataSource, Briefings {

    @IBOutlet weak var tableView: UITableView!
    var newsFeeds:[News] = [News]()
    var feeds:NewsFeeds = NewsFeeds()
    var selection:News?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feeds.delegate = self
        feeds.getFeeds()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func newsData() {
        self.newsFeeds = self.feeds.feedsData
        self.tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeeds.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)
        let titleLabel = cell.viewWithTag(2) as! UILabel
        titleLabel.text = newsFeeds[indexPath.row].title
        
        let publishLabel = cell.viewWithTag(3) as! UILabel
        publishLabel.text = newsFeeds[indexPath.row].publish
        
        let description = cell.viewWithTag(4) as! UILabel
        description.text = newsFeeds[indexPath.row].newsDescript
        
        let urlString = newsFeeds[indexPath.row].newsImage
        let thumbnail = NSURL(string: urlString)
        if thumbnail != nil{
            let request = NSURLRequest(url: thumbnail! as URL)
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data:Data?, reponse:URLResponse?, error:Error?) -> Void in
                DispatchQueue.main.async(execute: {() -> Void in
                    let imageView = cell.viewWithTag(1) as! UIImageView
                    imageView.image = UIImage(data: data!)
                })
            })
            dataTask.resume()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selection = newsFeeds[indexPath.row]
        self.performSegue(withIdentifier: "newSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newsView = segue.destination as! NewsDetails
        newsView.selection = self.selection
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
