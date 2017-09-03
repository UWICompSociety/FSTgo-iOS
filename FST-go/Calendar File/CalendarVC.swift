//
//  CalendarVC.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/27/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit
import Foundation


class CalendarVC: UIViewController, UITableViewDelegate,UITableViewDataSource,calendarDelegate{
   
    @IBOutlet weak var eventsTable: UITableView!
    var calendar:[Event] = [Event]()
    var event:Calendar = Calendar()
    var select:Event?
    
    @IBOutlet weak var popUp: UIView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
   
    @IBOutlet weak var eventTime: UILabel!
   
    @IBOutlet weak var background: UIButton!
    @IBOutlet weak var centrePop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.eventsTable.delegate = self
        self.eventsTable.dataSource = self
        self.event.delegate = self
        event.getEvents()
        
        popUp.layer.cornerRadius = 10
        popUp.layer.masksToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        centrePop.constant = -1000
        UIView.animate(withDuration: 0.1) { 
            self.view.layoutIfNeeded()
            self.background.alpha = 0
        }
    }
    @IBAction func share(_ sender: Any) {
        let activity = UIActivityViewController(activityItems: [self.select?.title as Any, self.select?.date as Any, self.select?.time as Any, self.select?.eventDescription as Any], applicationActivities: nil)
        activity.popoverPresentationController?.sourceView = self.view
        
        self.present(activity, animated: true, completion: nil)
    }
    func calendarData() {
        self.calendar = self.event.calendar
        self.eventsTable.reloadData()
    }
    func selection(){
        if let eventSelect = self.select{
            self.eventTitle.text = eventSelect.title
            self.eventDescription.text = eventSelect.eventDescription
            self.eventDate.text = eventSelect.date
            self.eventTime.text = eventSelect.time
        }
            
        
    }
    func show(){
        selection()
        centrePop.constant = 0
        UIView.animate(withDuration: 0.4) { 
            self.view.layoutIfNeeded()
            self.background.alpha = 0.5
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calendar.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "calCell", for: indexPath)
        
        let titleLabel = cell.viewWithTag(1) as! UILabel
        titleLabel.text = calendar[indexPath.row].title
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.select = calendar[indexPath.row]
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

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

