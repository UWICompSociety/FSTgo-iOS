//
//  PhotosVC.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/9/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage




class PhotosVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,photoDelegate {

    @IBOutlet var photoAlbum: UICollectionView!
    
    @IBOutlet weak var popUp: UIView!
    @IBOutlet weak var centrePopUp: NSLayoutConstraint!
    var photo:[Photo] = [Photo]()
    let gallery:Album = Album()
    var selection:Photo?
    var selectNum:Int = 0
    
    @IBOutlet var leftGesture: UISwipeGestureRecognizer!
    @IBOutlet var rightGesture: UISwipeGestureRecognizer!
    @IBOutlet weak var selectedPhoto: UIImageView!
    
    @IBOutlet weak var background: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SVProgressHUD .show(withStatus: "Loading...")
        self.photoAlbum.delegate = self
        self.photoAlbum.dataSource = self
        self.gallery.photodelegate = self
        gallery.getPhotos()
    
        
        let size = UIScreen.main.bounds.width/5 - 5
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: size, height: size)
        
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        photoAlbum.collectionViewLayout = layout
        popUp.layer.cornerRadius = 10
        popUp.layer.masksToBounds = true
        
        //self.selectedPhoto.isUserInteractionEnabled = true
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func photoData() {
        self.photo = self.gallery.Album
        self.photoAlbum.reloadData()
    }
    func show(){
        photoSelection()
        centrePopUp.constant = 0
        UIView.animate(withDuration: 0.4) { 
            self.view.layoutIfNeeded()
            self.background.alpha = 0.5
        }
        self.leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        self.leftGesture.direction = UISwipeGestureRecognizerDirection.left
        self.popUp.addGestureRecognizer(self.leftGesture)
        
        self.rightGesture = UISwipeGestureRecognizer(target: self.selectedPhoto, action: #selector(swipeAction(swipe:)))
        self.rightGesture.direction = UISwipeGestureRecognizerDirection.right
        self.popUp.addGestureRecognizer(self.rightGesture)
    }
    func photoSelection(){
        if let selectImage = self.selection{
            let urlString = selectImage.image
            let thumbnail = NSURL(string: urlString)
            if let url = thumbnail{
                self.selectedPhoto.sd_setImage(with: url as URL!)
            }
        }
    }
    func swipeAction(swipe:UISwipeGestureRecognizer){
        var imageIndex = self.selectNum
        switch swipe.direction {
        case UISwipeGestureRecognizerDirection.right:
            imageIndex -= 1
            self.selection = photo[imageIndex]
            photoSelection()
        
        case UISwipeGestureRecognizerDirection.left:
            imageIndex += 1
            self.selection = photo[imageIndex]
            photoSelection()
        
        default:
            print("Error could not skip")
        }
        
    
    }
    
    
    @IBAction func dismissPopUp(_ sender: Any) {
        centrePopUp.constant = -1000
        UIView.animate(withDuration: 0.1) { 
            self.view.layoutIfNeeded()
            self.background.alpha = 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoAlbum.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath)
        
        let urlString = photo[indexPath.row].image
        let thumbnail = NSURL(string: urlString)
        if let url = thumbnail{
            let imageView = cell.viewWithTag(1) as! UIImageView
            imageView.sd_setImage(with: url as URL!)
        }
        
        SVProgressHUD .dismiss()
        return cell
    }
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selection = photo[indexPath.row]
        self.selectNum = indexPath.row
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
