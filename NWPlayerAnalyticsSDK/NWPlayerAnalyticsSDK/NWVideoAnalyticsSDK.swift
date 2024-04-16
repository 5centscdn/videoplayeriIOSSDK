//
//  NWVideoAnalyticsSDK.swift
//  VideoPlayerAnalytics
//
//  Created by Mamun Ar Rashid on 22/6/23.
//


import Foundation
import WebKit
import AVKit

public class NWVideoAnalyticsSDK {
    
    private static var player: AVPlayer? = nil
    private static var url: String? = nil
    
    private static let core = NWVideoPlayer()
    
    public class func initAVPlayerViewController(_ playerViewController: AVPlayerViewController, hash_id:String, url:String, title: String, tags: [String], pageLoad: Int, showcv: Bool = false) {
        self.player = playerViewController.player
        self.url = url
        UserDefaults.standard.setValue(hash_id, forKey: "hash_id")
        UserDefaults.standard.setValue(url, forKey: "url")
        UserDefaults.standard.setValue(title, forKey: "title")
        UserDefaults.standard.setValue(tags, forKey: "tags")
        UserDefaults.standard.setValue(pageLoad, forKey: "pageLoad")
        UserDefaults.standard.setValue(showcv, forKey: "showcv")
        core.setupPlayerVC(controller: playerViewController, hash_id: hash_id, url:url)
    }
    
    public class func initAVPlayer(_ playerAV: AVPlayer, hash_id:String, url:String, title: String, tags: [String], pageLoad: Int, showcv: Bool = false) {
        self.player = playerAV
        self.url = url
        UserDefaults.standard.setValue(hash_id, forKey: "hash_id")
        UserDefaults.standard.setValue(url, forKey: "url")
        UserDefaults.standard.setValue(title, forKey: "title")
        UserDefaults.standard.setValue(tags, forKey: "tags")
        UserDefaults.standard.setValue(pageLoad, forKey: "pageLoad")
        UserDefaults.standard.setValue(showcv, forKey: "showcv")
        core.setupPlayer(player: self.player!, hash_id: hash_id, url:url)
    }

    public class func initAVPlayerLayer(_ playerLayer:AVPlayerLayer, hash_id:String, url:String, title: String, tags: [String], pageLoad: Int, showcv: Bool = false) {
        self.player = playerLayer.player
        self.url = url
        UserDefaults.standard.setValue(hash_id, forKey: "hash_id")
        UserDefaults.standard.setValue(url, forKey: "url")
        UserDefaults.standard.setValue(title, forKey: "title")
        UserDefaults.standard.setValue(tags, forKey: "tags")
        UserDefaults.standard.setValue(pageLoad, forKey: "pageLoad")
        UserDefaults.standard.setValue(showcv, forKey: "showcv")
        core.setupPlayer(player: self.player!,  hash_id:hash_id, url:url)
    }
    
}
