//
//  popUpView.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/13/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit
import SDWebImage

class popUpView: UIView{
    var selection:Photo?
    var effectChange:UIVisualEffect!
    var photo:PhotosVC = PhotosVC()
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    @IBOutlet weak var photoView: UIImageView!
    
    
    
    /*func photoGO() {
        self.selection?.image = (self.photo.selection?.image)!
        if let photoSelect = self.selection{
            let imageString = photoSelect.image
            let thumbnail = NSURL(string: imageString)
            if let url = thumbnail{
                self.photoView.sd_setImage(with: url as URL!)
            }
        }
        animateOn()
        
    }*/
    
    @IBAction func dismissPopUp(_ sender: Any) {
        animateOff()
    }
    func viewDidLoad() {
        effectChange = visualEffect.effect
        visualEffect.effect = nil
        self.selection?.image = (self.photo.selection?.image)!
        if let photoSelect = self.selection{
            let imageString = photoSelect.image
            let thumbnail = NSURL(string: imageString)
            if let url = thumbnail{
                self.photoView.sd_setImage(with: url as URL!)
            }
        }
        animateOn()
        
    }
    /*override func viewDidAppear(_ animated: Bool) {
        if let photo = self.selection{
            let imageString = photo.image
            let thumbnail = NSURL(string: imageString)
            if let url = thumbnail{
                self.photoView.sd_setImage(with: url as URL!)
            }
        }
        animateOn()
    }*/
    
    func animateOn(){
        let image = self.viewWithTag(5) as! UIImageView
        
        photoView.center = image.center
        photoView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        photoView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.visualEffect.effect = self.effectChange
            self.photoView.alpha = 1
            self.photoView.transform = CGAffineTransform.identity
        }
    }
    func animateOff(){
        UIView.animate(withDuration: 0.3, animations: {
            self.photoView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.photoView.alpha = 0
            self.visualEffect.effect = nil
        }) { (success:Bool) in
            self.photoView.removeFromSuperview()
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
