//
//  HomeScreenVC.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/31/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit

class HomeScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        UIView.animate(withDuration: 0.15, animations: {
            
            self.performSegue(withIdentifier: "mainSegue", sender: self)
            //let mainMenu = self.storyboard?.instantiateViewController(withIdentifier: "mainNav")*/
            //self.navigationController?.pushViewController(mainMenu!, animated: true)
        })
        
    }
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }*/
    

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
