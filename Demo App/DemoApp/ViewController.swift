//
//  ViewController.swift
//  DemoApp
//
//  Created by Mamun Ar Rashid on 8/7/23.
//

import UIKit
import AVKit
import AVFoundation
import NWPlayerAnalyticsSDK

class ViewController: UIViewController {

       @IBOutlet weak var hashIDTextField: UITextField!
         
       @IBOutlet weak var titleTextField: UITextField!
         
       @IBOutlet weak var tagsTextField: UITextField!
         
       @IBOutlet weak var urlTextField: UITextField!
    
      @IBOutlet weak var logTextField: UILabel!
    
       @IBOutlet weak var showCVhButton: UISwitch!
    
    @IBOutlet weak var showLogButton: UISwitch!
    
    var playerVC = AVPlayerViewController()
    var activityView: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        hideActivityIndicator()

    }
    
    
    @IBAction func playVideoOne(_ sender:Any)
    {
        showActivityIndicator()
        
        var hash_id = "4gpuj6i3znoio7r4"
        //let video_url = "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_5MB.mp4"
        var video_url = "https://woj7lng8dg82-hls-live.5centscdn.com/103_push_2351_001/e5e09742e6d694d40e46bef24fd68815.sdp/playlist.m3u8"

        var title = "title"
        var tags = ["1080p","10s","30MB"]
        var pageLoad = 120
        var showcv = true
        
        
        if let text = hashIDTextField.text, !text.isEmpty
        {
            hash_id = text
        }
        
        if let text = titleTextField.text, !text.isEmpty
        {
            title = text
        }
        
        if let text = tagsTextField.text, !text.isEmpty
        {
            tags = text.components(separatedBy: ",")
        }
        
        if let text = urlTextField.text, !text.isEmpty
        {
            video_url = text
        }
        
     
        showcv = showCVhButton.isOn
        
        let videoURL = NSURL(string:video_url)
        let player = AVPlayer(url: videoURL! as URL)
        playerVC.player = player
        
        self.present(playerVC, animated: true) {
            self.playerVC.player!.play()
        }
    
        if let player = self.playerVC.player {
            NWVideoAnalyticsSDK.initAVPlayerViewController(playerVC, hash_id: hash_id, url: video_url, title: title, tags: tags, pageLoad: pageLoad, showcv: showcv)
        }

    }
    
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    
    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }

}

