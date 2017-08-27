
//
//  NewsDetails.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/20/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit
import SDWebImage

class NewsDetails: UIViewController {

    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var publishInfo: UILabel!
    @IBOutlet weak var newsThumbnail: UIImageView!
    @IBOutlet weak var newStory: UILabel!
    @IBOutlet weak var newsUrl: UILabel!
    
    var selection:News?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        if let news = self.selection{
            self.newsTitle.text = news.title
            self.publishInfo.text = news.publish
            self.newStory.text = news.newsStory
            self.newsUrl.text = news.newsUrl
            
            let urlString = news.newsImage
            
            let urlThumbnail = NSURL(string: urlString)
            if let url = urlThumbnail{
                self.newsThumbnail.sd_setImage(with: url as URL!)
            }
            
            /*if urlThumbnail != nil{
                let request = NSURLRequest(url: urlThumbnail! as URL)
                let session = URLSession.shared
                let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) -> Void in
                    
                })
                dataTask.resume()
            }*/
            
                /*let dataTask = session.dataTask(with: request, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) -> Void in
                    DispatchQueue.main.async(execute: { () -> Void in
                        
                    })
                })*/
            
        }
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


