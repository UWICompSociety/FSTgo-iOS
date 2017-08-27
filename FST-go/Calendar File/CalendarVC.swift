//
//  CalendarVC.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/27/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarVC: UIViewController {
    let dateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension CalendarVC: JTAppleCalendarViewDelegate,JTAppleCalendarViewDataSource{
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        dateFormatter.dateFormat = "yyyy mm dd"
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        let startDate = dateFormatter.date(from: "2016 01 01")!
        let endDate = dateFormatter.date(from: "2016 12 31")!
        
        let parameter = ConfigurationParameters(startDate: startDate, endDate: endDate)
        
        return parameter
    }
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        cell.dateLabel.text = cellState.text
        
        return cell
    }
}
