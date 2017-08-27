//
//  Details.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/20/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit

class Details: UIViewController {
    
    @IBOutlet weak var scholarDesc: UILabel!
    @IBOutlet weak var scholarTitle: UILabel!
    @IBOutlet weak var scholarDets: UILabel!
    @IBOutlet weak var scholarUrl: UILabel!
    
    var selection:Scholarship?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        if let scholar = self.selection{
            self.scholarTitle.text = scholar.schlorName
            self.scholarDesc.text = scholar.scholarDescript
            self.scholarDets.text = scholar.scholarDetail
            self.scholarUrl.text = scholar.scholarUrl
        }
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
