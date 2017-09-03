//
//  ViewController.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/1/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    @IBOutlet weak var mainMenu: UICollectionView!
    let buttonLabel:[String] = ["Calendar","Contacts","FAQs","News","Photos","Places","Scholarships and Bursaries","Shuttle Bus","Videos"]
    
    //storyboard IDs
    let viewControllerID = ["cal","con","faq","new","pho","pla","sch","shu","vid"]
    
    let buttonImage = [#imageLiteral(resourceName: "calendar1"),#imageLiteral(resourceName: "contacts1"),#imageLiteral(resourceName: "FAQ1"),#imageLiteral(resourceName: "news"),#imageLiteral(resourceName: "photos"),#imageLiteral(resourceName: "places"),#imageLiteral(resourceName: "scholarship"),#imageLiteral(resourceName: "bus"),#imageLiteral(resourceName: "videos")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Customize flow layout of view to override default flow layout
        
        let size = UIScreen.main.bounds.width/3 - 10
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: size, height: size)
        
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 30
        
        mainMenu.collectionViewLayout = layout
        
        self.mainMenu.delegate = self
        self.mainMenu.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonLabel.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Customizes cell to display button image and label
        let cell = mainMenu.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! mainCell
        cell.button.image = buttonImage[indexPath.row]
        cell.label.text = buttonLabel[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //perform programmatic segue from main menu to view of selected cell
        let id = viewControllerID[indexPath.row]
        let view = storyboard?.instantiateViewController(withIdentifier: id)
        self.navigationController?.pushViewController(view!, animated: true)
    }
}

