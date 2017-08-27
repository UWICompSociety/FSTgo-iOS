//
//  ScholarList.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/19/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit
import Alamofire
protocol achievers {
    func scholarData()
}
class ScholarList: NSObject {
    var scholarship:[Scholarship] = [Scholarship]()
    var delegate:achievers?
    func getScholars(){
        Alamofire.request("http://fast.mona.uwi.edu/scholarship", method: .get , headers: nil).responseJSON { response -> Void in
            switch response.result{
                case .success(let JSON):
                    let response = JSON as! NSArray
                    var scholarList = [Scholarship]()
                    for scholar in response{
                        let scholarObj = Scholarship()
                        scholarObj.schlorName = (scholar as AnyObject).value(forKey: "name") as! String
                        scholarObj.scholarDescript = (scholar as AnyObject).value(forKey: "description") as! String
                        scholarObj.scholarDetail = (scholar as AnyObject).value(forKey: "detail") as! String
                        scholarObj.scholarUrl = (scholar as AnyObject).value(forKey: "application_url") as! String
                        scholarList.append(scholarObj)
                    }
                    self.scholarship = scholarList
                    if self.delegate != nil{
                        self.delegate!.scholarData()
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
}
