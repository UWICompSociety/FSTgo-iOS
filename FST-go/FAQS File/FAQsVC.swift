//
//  FAQsVC.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/7/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit

class FAQsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, FAQS {
    var list:[Faqs] = [Faqs]()
    var selecton:Faqs?
    let format:FaqList = FaqList()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.format.delegate = self
        format.getlist()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func faqData() {
        self.list = self.format.list
        self.tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "faqCell", for: indexPath)
        
        let titleLabel = cell.viewWithTag(1) as! UILabel
        titleLabel.text = list[indexPath.row].title
        
        let detailLabel = cell.viewWithTag(2) as! UILabel
        detailLabel.text = list[indexPath.row].detail
        return cell
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
