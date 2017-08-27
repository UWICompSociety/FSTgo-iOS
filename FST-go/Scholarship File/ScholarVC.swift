//
//  ScholarVC.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/19/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit

class ScholarVC: UIViewController,UITableViewDelegate, UITableViewDataSource, achievers {

    @IBOutlet weak var tableView: UITableView!
    var scholarships:[Scholarship] = [Scholarship]()
    var scholar:ScholarList = ScholarList()
    var selection:Scholarship?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scholar.delegate = self
        scholar.getScholars()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func scholarData() {
        self.scholarships = self.scholar.scholarship
        self.tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scholarships.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scholarCell", for: indexPath)
        let label = cell.viewWithTag(1) as! UILabel
        label.text = scholarships[indexPath.row].schlorName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selection = self.scholarships[indexPath.row]
        self.performSegue(withIdentifier: "scholSegue", sender: self)
    }
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
        let view = segue.destination as! Details
        view.selection = self.selection
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
