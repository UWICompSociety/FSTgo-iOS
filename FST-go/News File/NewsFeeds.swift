//
//  NewsFeeds.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/20/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit
import Alamofire
protocol Briefings {
    func newsData()
}
class NewsFeeds: NSObject {
    var feedsData:[News] = [News]()
    var delegate:Briefings?
    func getFeeds(){
        Alamofire.request("http://fast.mona.uwi.edu/news", method: .get , headers: nil).responseJSON { response -> Void in
            switch response.result{
                case .success(let JSON):
                    let response = JSON as! NSArray
                    var stories = [News]()
                    for page in response{
                        let newsObj = News()
                        newsObj.title = (page as AnyObject).value(forKey: "title") as! String
                        newsObj.publish = (page as AnyObject).value(forKey: "created") as! String
                        newsObj.newsDescript = (page as AnyObject).value(forKey: "description") as! String
                        newsObj.newsStory = (page as AnyObject).value(forKey: "story") as! String
                        newsObj.newsImage = (page as AnyObject).value(forKey: "image_url") as! String
                        newsObj.newsUrl = (page as AnyObject).value(forKey: "news_url") as! String
                        
                        stories.append(newsObj)
                    }
                    self.feedsData = stories
                    if self.delegate != nil{
                        self.delegate!.newsData()
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
}
