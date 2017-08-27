//
//  MediaPlayer.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/4/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit
import Alamofire

protocol videoDelegate {
    func vidData()
}
class MediaPlayer: NSObject {
    let API = "AIzaSyB6a5HCXRklh6QrNO0hodDb-ug6QTV_zjc"
    let playList = "UUGH2o33wmSvi3iKHgvL-ybQ"
    let channel = "UCGH2o33wmSvi3iKHgvL-ybQ"
    
    var videoArray = [Video]()
    
    var delegate:videoDelegate?
    
    func getFeeds() {
        Alamofire.request("https://www.googleapis.com/youtube/v3/playlistItems", method: .get, parameters: ["part":"snippet", "playlistId":playList, "key":API,"channelId":channel,"maxResults":50],headers: nil).responseJSON { response -> Void in
            
            switch response.result{
                case .success(let JSON):
                    let response = JSON as! NSDictionary
                    let dict = response.object(forKey: "items") as! NSArray
                    var vidArray = [Video]()
                    
                    for item in dict{
                    
                        let  vidObj = Video()
                        vidObj.videoId = (item as AnyObject).value(forKeyPath: "snippet.resourceId.videoId") as! String
                        vidObj.videoTitle = (item as AnyObject).value(forKeyPath: "snippet.title") as! String
                        vidObj.videoDescription = (item as AnyObject).value(forKeyPath: "snippet.description") as! String
                        vidObj.videoThumbnail = (item as AnyObject).value(forKeyPath: "snippet.thumbnails.high.url") as! String
                        vidArray.append(vidObj)
                    }
                    self.videoArray = vidArray
                    if self.delegate != nil {
                        self.delegate!.vidData()
                    }
                
                case .failure(let error):
                    print(error)
        
            }
        }
    }
}
