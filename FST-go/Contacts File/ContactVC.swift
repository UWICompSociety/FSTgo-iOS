//
//  ContactVC.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/7/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit

class ContactVC: UIViewController, UITableViewDelegate,UITableViewDataSource, PhoneBook {
    
    @IBOutlet var popUp: UIView!
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var effectChange:UIVisualEffect!
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
        effectChange = visualEffect.effect
        visualEffect.effect = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func dismiss(_ sender: Any) {
        animateOff()
    }
    func contactData() {
        self.contacts = self.phone.contactList
        self.tableView.reloadData()
    }
    func animateOn(){
        
        print("here")
        popUp.center = self.tableView.center
        popUp.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        popUp.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.visualEffect.effect = self.effectChange
            self.popUp.alpha = 1
            self.popUp.transform = CGAffineTransform.identity
        }
    }
    func animateOff(){
        UIView.animate(withDuration: 0.3, animations: {
            self.popUp.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.popUp.alpha = 0
            self.visualEffect.effect = nil
        }) { (success:Bool) in
            self.popUp.removeFromSuperview()
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
        self.numberLabel.text = self.contacts[indexPath.row].contactNumber
        self.emailLabel.text = self.contacts[indexPath.row].contactEmail
        self.websiteLabel.text = self.contacts[indexPath.row].contactWebsite
        animateOn()
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
