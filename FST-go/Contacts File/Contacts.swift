//
//  Contacts.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/17/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit
import Alamofire
protocol PhoneBook{
    func contactData()
}
class Contacts: NSObject {
    var contactList = [Contact]()
    var delegate:PhoneBook?
    
    func getContacts(){
        Alamofire.request("http://fast.mona.uwi.edu/contacts", method: .get , headers: nil).responseJSON { response -> Void in
            switch response.result{
                case .success(let JSON):
                    let response = JSON as! NSArray
                    var contacts = [Contact]()
                    for contact in response{
                        let conObj = Contact()
                        conObj.contactName = (contact as AnyObject).value(forKey: "name") as! String
                        conObj.contactNumber = (contact as AnyObject).value(forKey: "number") as! String
                        conObj.contactEmail = (contact as AnyObject).value(forKey: "email") as! String
                        conObj.contactWebsite = (contact as AnyObject).value(forKey: "website") as! String
                        contacts.append(conObj)
                    }
                    self.contactList = contacts
                    if self.delegate != nil{
                        self.delegate!.contactData()
                    }
                case .failure(let error):
                    print(error)
            
            }
        }
    
    }
}
