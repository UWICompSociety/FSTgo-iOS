//
//  ShuttleVC.swift
//  FST-go
//
//  Created by ShanielleWilli on 9/2/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit

class ShuttleVC: UIViewController , UITableViewDelegate, UITableViewDataSource{
    //var busName:[String] = ["Bus Route A","Bus Route B","Bus Route C","Bus Route D"]
    var busTitle = String()
    var busRoute = String()
    var Shuttle:[ShuttleBus] = []
    
    @IBOutlet weak var busTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.busTable.delegate = self
        self.busTable.dataSource = self
        
        if let path = Bundle.main.url(forResource: "bus", withExtension: "xml"){
            if let parser = XMLParser(contentsOf: path){
                parser.delegate = self as? XMLParserDelegate
                parser.parse()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Shuttle.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shuttleCell", for: indexPath)
        
        let bus = Shuttle[indexPath.row]
        
        let busTitle = cell.viewWithTag(1) as! UILabel
        busTitle.text = bus.busTitle
        
        let busRoute = cell.viewWithTag(2) as! UILabel
        busRoute.text = bus.busRoute
        
        
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
