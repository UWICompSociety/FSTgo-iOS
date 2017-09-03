//
//  Calendar.swift
//  FST-go
//
//  Created by ShanielleWilli on 9/1/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

protocol calendarDelegate {
    func calendarData()
}
class Calendar: NSObject {
    var calendar = [Event]()
    var delegate:calendarDelegate?
    
    func getEvents(){
        Alamofire.request("http://fast.mona.uwi.edu/events", method: .get , headers: nil).responseJSON { response -> Void in
            switch response.result{
                case .success(let JSON):
                    let response = JSON as! NSArray
                    var eventArray = [Event]()
                    for event in response{
                        let eventObj = Event()
                        eventObj.title = (event as AnyObject).value(forKey: "title") as! String
                        
                        let date = (event as AnyObject).value(forKey: "date") as! String
                        var dateArray = date.components(separatedBy: "T")
                        eventObj.date = dateArray[0]
                        
                        let time = dateArray[1]
                        var timeArray = time.components(separatedBy: "Z")
                        eventObj.time = timeArray[0]
                        
                        
                        eventObj.eventDescription = (event as AnyObject).value(forKey: "description") as! String
                        eventArray.append(eventObj)
                    }
                    eventArray.sort(by: {$0.date < $1.date})
                    self.calendar = eventArray
                    if self.delegate != nil{
                        self.delegate!.calendarData()
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
}
