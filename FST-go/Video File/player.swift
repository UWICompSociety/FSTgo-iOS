//
//  player.swift
//  FST-go
//
//  Created by ShanielleWilli on 8/5/17.
//  Copyright © 2017 ShanielleWilli. All rights reserved.
//

import UIKit
import SVProgressHUD

class player: UIViewController {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var videoDescription: UILabel!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var webView: UIWebView!
    
    var selection:Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SVProgressHUD .show(withStatus: "Loading...")
        self.webView.frame = self.view.bounds
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if let vid = self.selection{
            self.videoTitle.text = vid.videoTitle
            self.videoDescription.text = vid.videoDescription
            
            let width = self.view.frame.size.width
            let height = width/246 * 138
            self.heightConstraint.constant = height
            
            let videoString = "<html><head><style type=\"text/css\">body {background-color: transparent;color: white;}</style></head><body style=\"margin:0\"><iframe frameBorder=\"0\" height=\"" + String(describing: height) + "\" width=\"" + String(describing: width) + "\" src=\"http://www.youtube.com/embed/" + vid.videoId + "?showinfo=0&modestbranding=1&frameborder=0&rel=0\"></iframe></body></html>"
            
            self.webView.loadHTMLString(videoString, baseURL: nil)
        }
        SVProgressHUD .dismiss()
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
