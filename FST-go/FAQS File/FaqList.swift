//
//  FaqList.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/7/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit
import Alamofire

protocol FAQS {
    func faqData()
}
class FaqList: NSObject {
    var list = [Faqs]()
    var delegate:FAQS?
    func getlist(){
        
        Alamofire.request("http://fast.mona.uwi.edu/faqs", method: .get , headers: nil).responseJSON { response -> Void in
            switch response.result{
                case .success(let JSON):
                    let response = JSON as! NSArray
                    var faqs = [Faqs]()
                    for quest in response{
                        let faqObj = Faqs()
                        faqObj.title = (quest as AnyObject).value(forKey: "question") as! String
                        faqObj.detail = (quest as AnyObject).value(forKey: "answer") as! String
                        faqs.append(faqObj)
                    }
                self.list = faqs
                if self.delegate != nil{
                    self.delegate!.faqData()
                }
                case .failure(let error):
                    print(error)
            }
        }
    }
}
