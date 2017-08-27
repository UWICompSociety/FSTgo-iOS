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

    @IBOutlet weak var photoAlbum: UICollectionView!
    
    var photo:[Photo] = [Photo]()
    let gallery:Album = Album()
    var selection:Photo?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SVProgressHUD .show(withStatus: "Loading...")
        photoAlbum.delegate = self
        photoAlbum.dataSource = self
        self.gallery.photodelegate = self
        gallery.getPhotos()
    
        
        let size = UIScreen.main.bounds.width/5 - 5
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: size, height: size)
        
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        photoAlbum.collectionViewLayout = layout
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func photoData() {
        self.photo = self.gallery.Album
        self.photoAlbum.reloadData()
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
        selection?.image = photo[indexPath.row].image
        
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
