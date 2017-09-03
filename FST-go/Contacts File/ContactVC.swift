//
//  ContactVC.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/7/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class ContactVC: UIViewController, UITableViewDelegate,UITableViewDataSource, PhoneBook {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var popUp: UIView!
    
    @IBOutlet weak var background: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var centerPopUp: NSLayoutConstraint!
   
    //var effectChange:UIVisualEffect!
    var select:Contact?
    var contacts:[Contact] = [Contact]()
    let phone:Contacts = Contacts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.phone.delegate = self
        phone.getContacts()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
        popUp.layer.cornerRadius = 10
        popUp.layer.masksToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func show() {
        selection()
        centerPopUp.constant = 0
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
            self.background.alpha = 0.5
        
        })
        
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        centerPopUp.constant = -1000
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
            self.background.alpha = 0
        })
        
    }
    func selection(){
        if let info = self.select{
            self.numberLabel.text = info.contactNumber
            self.emailLabel.text = info.contactEmail
            self.websiteLabel.text = info.contactWebsite
        }
        
    }
    
    func contactData() {
        self.contacts = self.phone.contactList
        self.tableView.reloadData()
    }
    
    @IBAction func phoneCall(_ sender: Any) {
        let phone = self.select?.contactNumber
        let number:String = "telprompt://\(String(describing: phone))"
        if let phone_call = URL(string: number){
            UIApplication.shared.open(phone_call, options: [:], completionHandler: nil)
        }
        
    }
    
    
    @IBAction func sendEmail(_ sender: Any) {
        let emailAddress = self.select?.contactEmail
        let email:String = "mailto://\(String(describing: emailAddress))"
        if let url = URL(string: email){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func browseWeb(_ sender: Any) {
        let urlString = self.select?.contactWebsite
        if let url = URL(string: urlString!){
            let browse = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            present(browse, animated: true, completion: nil)
        }
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "conCell", for: indexPath)
        let label = cell.viewWithTag(1) as! UILabel
        label.text = contacts[indexPath.row].contactName
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.select = contacts[indexPath.row]
        show()
        
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
