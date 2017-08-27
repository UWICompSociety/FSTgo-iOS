//
//  Map.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/22/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit
import Alamofire

protocol PlaceMap {
    func mapData()
}
class Map: NSObject {
    var locations:[Places] = [Places]()
    var delegate:PlaceMap?
    func getLocation(){
       Alamofire.request("http://fast.mona.uwi.edu/places", method: .get , headers: nil).responseJSON { response -> Void in
            switch response.result{
                case .success(let JSON):
                    let response = JSON as! NSArray
                    var locate = [Places]()
                    for point in response{
                        let placeObj = Places()
                        placeObj.placesFullname = (point as AnyObject).value(forKey: "fullname") as! String
                        placeObj.placesNickname = (point as AnyObject).value(forKey: "shortname") as! String
                        placeObj.department = (point as AnyObject).value(forKey: "department") as! String
                        placeObj.location = (point as AnyObject).value(forKey: "location") as! String
                        
                        locate.append(placeObj)
                    }
                self.locations = locate
                if self.delegate != nil{
                    self.delegate!.mapData()
                }
                case .failure(let error):
                    print(error)
            }
        }
    }
}
