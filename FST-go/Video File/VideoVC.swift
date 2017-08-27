//
//  VideoVC.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/4/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit

class VideoVC: UIViewController , UITableViewDelegate , UITableViewDataSource, videoDelegate {

    
    
    @IBOutlet weak var table: UITableView!
    var videos:[Video] = [Video]()
    var selection:Video?
    let model:MediaPlayer = MediaPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.model.delegate = self
        model.getFeeds()
        
        self.table.delegate = self
        self.table.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func vidData() {
        self.videos = self.model.videoArray
        self.table.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.frame.size.width/320) * 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath)
        
        let label = cell.viewWithTag(2) as! UILabel
        label.text = videos[indexPath.row].videoTitle
        
        let urlString = videos[indexPath.row].videoThumbnail
        
        let vidThumbnail = NSURL(string: urlString)
        
        if vidThumbnail != nil{
            let request = NSURLRequest(url: vidThumbnail! as URL)
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler :
            { (data : Data?, reponse : URLResponse? , error : Error?) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                let imageView = cell.viewWithTag(1) as! UIImageView
                
                imageView.image = UIImage(data:data!)
                })
            })
          
            dataTask.resume()
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selection = self.videos[indexPath.row]
        self.performSegue(withIdentifier: "vidSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! player
        
        viewController.selection = self.selection
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
