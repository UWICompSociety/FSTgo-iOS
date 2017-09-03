//
//  Album.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/10/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit
import Alamofire
protocol photoDelegate {
    func photoData()
}
class Album: NSObject {
    var Album = [Photo]()
    var photodelegate:photoDelegate?

    
    func getPhotos() {
        Alamofire.request("http://fast.mona.uwi.edu/images", method: .get , headers: nil).responseJSON { response -> Void in
            switch response.result{
                case .success(let JSON):
                    let response = JSON as! NSArray
                    var albumArray = [Photo]()
                
                    for image in response{
                        let picObj = Photo()
                        picObj.image = (image as AnyObject).value(forKey: "url") as! String
                        albumArray.append(picObj)
                    }
                    self.Album = albumArray
                    if self.photodelegate != nil{
                        self.photodelegate!.photoData()
                    }
                case .failure(let error):
                    print(error)
            }
        }
    
    }
}
