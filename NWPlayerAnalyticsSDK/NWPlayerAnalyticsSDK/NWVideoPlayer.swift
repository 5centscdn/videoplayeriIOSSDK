//
//  NWVideoPlayer.swift
//  VideoPlayerAnalytics
//
//  Created by Mamun Ar Rashid on 22/6/23.
//


import UIKit
import Foundation
import AVKit
import AVFoundation
import SystemConfiguration
import Security
import MachO
import WebKit


public class NWVideoPlayer: NSObject {
    
    // MARK:- constants
    var player = AVPlayer()
    var controller: AVPlayerViewController?
    var currentPlayerItem: AVPlayerItem?
    var timer : Timer?
    var timerViewCount : Timer?
    let label = UILabel()
    var isProtrait: Bool = true
    var count: Int = 0
    //MARK:- Setup Player
    public func setupPlayerVC(controller:AVPlayerViewController, hash_id: String, url:String)
    {
        self.controller = controller
        
        self.player = controller.player ?? AVPlayer()
        currentPlayerItem = self.player.currentItem
        
        init_SDK()
    }
    
    //MARK:- Setup Player
    public func setupPlayer(player:AVPlayer, hash_id: String, url:String)
    {
        self.player = player
        currentPlayerItem = self.player.currentItem
        init_SDK()
    }
    
    public func playerReady()
    {
//        isEventsetup = false
//       // eventName = Events.isPlayerReady.rawValue
//       // let state = gumletTranstion.transitionState(eventName: eventName, currentState: currentState, destinationState: GumletPlayerStateMachine.GumletPlayerStateReady.rawValue)
//        if state == true
//        {
//            let prevEvents = UserDefaults.standard.value(forKey: "eventName") as! String
//            UserDefaults.standard.setValue(eventName, forKey: "eventName")
//            play_current_time = getPlay_Pause_Time()
//            callEventsAPI(eventTime: play_current_time, previousEvents:prevEvents, eventName: eventName)
//        }
        //currentState = GumletPlayerStateMachine.GumletPlayerStateReady.rawValue
       // UserDefaults.standard.setValue(currentState, forKey: "currentState")
//        DispatchQueue.main.async {
//            let interval = CMTimeMakeWithSeconds(0.1, preferredTimescale:Int32(NSEC_PER_MSEC))// CMTime(seconds: 1, preferredTimescale: 10)
//            self.timeObservation = self.player.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: {
//                [weak self] time in
//                guard let weakSelf = self else {
//                    return }
//                let seconds = CMTimeGetSeconds(time)
//                weakSelf.checkForSeekEvent()
//                weakSelf.checkVideoQualityChange()
//                weakSelf.checkMuteAnUnmute()
//                weakSelf.updateLastPlayheadTime()
//            })
//        }
    }

    public func callPlaying(currentState:String, playCurrentTime:Double)
    {

    }
    
    func callPlaybackStarted()
    {
//        eventName = Events.isPlaybackStarted.rawValue
//        let prevEvents = UserDefaults.standard.value(forKey: "eventName") as! String
//        UserDefaults.standard.setValue(eventName, forKey: "eventName")
//        callEventsAPI(eventTime: 0.0, previousEvents:prevEvents, eventName: eventName)
//        currentState = GumletPlayerStateMachine.GumletPlayerStatePlaying.rawValue
    }

    @objc func updateTimer()
    {
        let eventHandler = EventHandler()
        eventHandler.pullEvery10SEvent()
    }
    
    public func callVideoChange()
    {
//        timer?.invalidate()
//        isVideoChange = false
//        eventName = Events.isVideochange.rawValue
//        let state = gumletTranstion.transitionState(eventName: eventName, currentState: currentState, destinationState: currentState)
//        if state == true
//        {
//        var prevEvents :String? = ""
//        if prevEvents != nil{
//            prevEvents = (UserDefaults.standard.value(forKey: "eventName") as! String)
//        }
//        else{
//            prevEvents = ""
//        }
//        UserDefaults.standard.setValue(eventName, forKey: "eventName")
//        play_current_time = getPlay_Pause_Time()
//        callEventsAPI(eventTime: play_current_time, previousEvents:prevEvents!, eventName: eventName)
//        }
    }
    
 
    
    func callError()
    {
        if (player.error != nil)
        {
            let errCode = player.error! as NSError
//            errorCode = errCode.code
//            errorTitle = errCode.domain
//            errorMessage = errCode.localizedDescription
        }
        else if ((currentPlayerItem != nil) && (currentPlayerItem?.error != nil))
        {
            let errCode = (currentPlayerItem?.error)! as NSError
//            errorMessage = errCode.localizedDescription
//            errorCode = errCode.code
//            errorTitle = errCode.domain
        }
    
    }
    
 
    @objc func appMovedToBackground()
    {
        UserDefaults.standard.setValue(Date(), forKey: "backgroundCurrentTime")
    }

   @objc func appCameToForeground()
   {
      UserDefaults.standard.setValue(Date(), forKey: "foregroundCurrentTime")
   }
    
    
    @objc func playerDidFinishPlaying()
    {
        
        timer?.invalidate()
        timer = nil

       // eventName = Events.isEnd.rawValue
       // let state = gumletTranstion.transitionState(eventName: eventName, currentState: currentState, destinationState: NWPlayerState.end.rawValue)
        if true
        {
           // let prevEvents = UserDefaults.standard.value(forKey: "eventName") as! String
           // UserDefaults.standard.setValue(eventName, forKey: "eventName")
            //play_current_time = getPlay_Pause_Time()
            //callEventsAPI(eventTime: play_current_time, previousEvents:prevEvents, eventName: eventName)
        }
       // currentState = GumletPlayerStateMachine.GumletPlayerStateViewEnd.rawValue
       // UserDefaults.standard.setValue(currentState, forKey: "currentState")
        let eventHandler = EventHandler()
        eventHandler.playCompleteEvent()
    }
    
   @objc func handleAVPlayerError(notification: Notification)
   {
        let isNotificationRelevant :Bool = checkIfNotificationIsRelevant(notif: notification as NSNotification)
       if (isNotificationRelevant)
       {
            let playerItem = notification.object as? AVPlayerItem
            let log:AVPlayerItemErrorLog? = playerItem!.errorLog()
            if (log != nil && log!.events.count > 0)
            {
                //https://developer.apple.com/documentation/avfoundation/avplayeritemaccesslogevent?language=objc
                let errorEvent : AVPlayerItemErrorLogEvent? = log!.events[log!.events.count - 1]
                let request_start = Int(Date().timeIntervalSince1970)//getDate()
                let request_response_start = Int(Date().timeIntervalSince1970)
                let request_response_end = Int(Date().timeIntervalSince1970)
                let requestError = errorEvent!.errorDomain;
                let request_type = "event_requestfailed";
                let requestUrl = (errorEvent?.uri)!;
                let requestHostName = getHostName(videoUrl: requestUrl)
                let requestErrorCode = errorEvent!.errorStatusCode
                guard let requestErrorText = errorEvent?.errorComment else { return };
//                callNetworkAPI(requestStart:request_start , requestrResponseStart: request_response_start, requestResponseEnd: request_response_end, requestType: request_type, requestHostName: requestHostName, requestBytesLoaded: 0, requestResponseHeaders: "", requestMediaDuration_millis: 0, errorCode: requestErrorCode, error: requestError, errorText: requestErrorText)
            }
        }
    }
    
        
    // Handle notification.
    @objc func handleAVPlayerAccess(notification: Notification)
    {
        guard let playerItem = notification.object as? AVPlayerItem,
              let lastEvent = playerItem.accessLog()?.events.last else
        {
            return
        }
//        if indicatedBitrate != Float(lastEvent.indicatedAverageBitrate)
//        {
//            indicatedBitrate = Float(lastEvent.indicatedAverageBitrate)
//        }
//        let isNotificationRelevant :Bool = checkIfNotificationIsRelevant(notif: notification as NSNotification)
//        if (isNotificationRelevant)
//        {
//            let playerItem = notification.object as? AVPlayerItem
//            let accessLog = playerItem!.accessLog()
//            //calculateBandwidthMetricFromAccessLog(log:accessLog!)
//        }
//        _lastTransferEventCount = 0
//        _lastTransferDuration = 0
//        _lastTransferredBytes = 0
    }
    
    func checkIfNotificationIsRelevant(notif:NSNotification) -> Bool
    {
        let notificationItem   = notif.object as! AVPlayerItem
        return notificationItem == currentPlayerItem
    }
    
    
    @objc func receiveAirPlayNotification(note: NSNotification)
    {
       // let eventHandler = EventHandler()
       // eventHandler.playerCore = self
        //play_current_time = getPlay_Pause_Time()
       // eventHandler.callScreenCastStart(playCurrentTime: play_current_time)
    }
    
    
    //MARK:- call key value observer for play and pause event
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        let eventHandler = EventHandler()
        let dataManager = DataManager()
        
        if object as AnyObject? === player {
           if keyPath == "status" {
            if player.status == .readyToPlay
                {
                if !dataManager.isvalid() {
                    player.pause()
                    return
                }
                
                   let viewid = UUID().uuidString
                   UserDefaults.standard.setValue(viewid, forKey: "view_id")
                    let localCurrentTime = getDate()
                    UserDefaults.standard.setValue(localCurrentTime, forKey: "playerinitiatetime")
               
                eventHandler.playEvent()
                
                if dataManager.showcv() {
                    
                    self.UpdateViewCount()
                    self.timerViewCount = Timer.scheduledTimer(timeInterval:10, target: self, selector: #selector(UpdateViewCount), userInfo: nil, repeats: true)
                    

                    //eventHandler.showcvAPICall() { count in
                        
                        //                        self.label.removeFromSuperview()
                        //                        self.label.text = "\(count)"
                        //                        self.label.layer.backgroundColor  = UIColor.red.cgColor
                        //                        self.label.layer.cornerRadius = 11
                        //                        self.label.layer.masksToBounds = true
                        //                        self.label.textColor = UIColor.white
                        //                        self.label.sizeToFit()
                        //                        self.label.textAlignment = .center;
                        
                        
                       
                        //
                        //                            if let playerViewController = self.controller {
                        //                                playerViewController.contentOverlayView?.addSubview(self.label)
                        //                                playerViewController.contentOverlayView?.addSubview(self.label)
                        //                                playerViewController.view.bringSubviewToFront(self.label)
                        //                                self.label.frame = CGRect(x: 80, y: playerViewController.view.bounds.size.height - 79, width: 50, height: 22)
                        //
                        //                            }
                        //                            else if let playerViewController = UIApplication.shared.windows.first?.rootViewController?.presentedViewController as? AVPlayerViewController {
                        //                                playerViewController.contentOverlayView?.addSubview(self.label)
                        //                                playerViewController.contentOverlayView?.addSubview(self.label)
                        //                                playerViewController.view.bringSubviewToFront(self.label)
                        //                                self.label.frame = CGRect(x: 80, y: playerViewController.view.bounds.size.height - 79, width: 50, height: 22)
                        //
                        //                            }
                        
                        
                    //}
                }
                    self.playerReady()
                }
                else if player.status == .failed
                {
                    callError()
                }
                else if player.status == .unknown
                {
                    callError()
                }
            }
            else if keyPath == "rate"
            {
                if player.rate == 1.0
                {
                    if !dataManager.isvalid() {
                        player.pause()
                        return
                    }
                    if let localCurrentTimeEvent = UserDefaults.standard.value(forKey: "playerinitiatetime") as? String {
                        let dFormatter = DateFormatter()
                        dFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
                        dFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
                        let initiateTime = dFormatter.date(from: localCurrentTimeEvent)
                        let iTime = Int(initiateTime!.timeIntervalSince1970 * 1000)
                        let nTime = Int(Date().timeIntervalSince1970 * 1000)
                        let diff = nTime - iTime
                        UserDefaults.standard.setValue(diff, forKey: "initime")
                        timer = Timer.scheduledTimer(timeInterval:10, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
                        eventHandler.allEventsAfterPlay()
                    }
                }
                else if player.rate == 0.0
                {
//                    let currentStates = UserDefaults.standard.value(forKey: "currentState") as! String
//                    play_current_time = getPlay_Pause_Time()
//                    //eventHandler.callPause(currentState: currentStates,playCurrentTime: play_current_time)
//                    currentState = NWPlayerState.paused.rawValue
//                    UserDefaults.standard.setValue(currentState, forKey: "currentState")
                    timer?.invalidate()
                    timer = nil
                }
            }
            else if keyPath == "timeControlStatus"
            {
               if player.timeControlStatus == .playing
                {
//                    if isBuffer == true {
//                    let currentStates = UserDefaults.standard.value(forKey: "currentState") as! String
//                    play_current_time = getPlay_Pause_Time()
//                   // eventHandler.callBufferingEnd(currentState: currentStates,playCurrentTime: play_current_time)
//                        self.currentState = NWPlayerState.buffering.rawValue
//                    UserDefaults.standard.setValue(currentState, forKey: "currentState")
//                    isBuffer = false
//                    }
//                    let currentStates = UserDefaults.standard.value(forKey: "currentState") as! String
//                    play_current_time = getPlay_Pause_Time()
//                   // callPlaying(currentState: currentStates,playCurrentTime: play_current_time)
//                   self.currentState = NWPlayerState.playing.rawValue
//                    UserDefaults.standard.setValue(currentState, forKey: "currentState")
               }
               else if player.timeControlStatus == .paused
               {
                    
               }
               else if player.timeControlStatus == .waitingToPlayAtSpecifiedRate
               {
//                    if isBuffer == false{
//                    let currentStates = UserDefaults.standard.value(forKey: "currentState") as! String
//                    play_current_time = getPlay_Pause_Time()
//                    //eventHandler.callBufferingStart(currentState: currentStates,playCurrentTime: play_current_time)
//                   // self.currentState = GumletPlayerStateMachine.GumletPlayerStateBuffering.rawValue
//                    UserDefaults.standard.setValue(currentState, forKey: "currentState")
//                    isBuffer = true
//                }
               }
            }
        }
    }
    
    //MARK:- init SDK
    
    public func init_SDK()
    {
        
        
        self.player.addObserver(self, forKeyPath: "status", options: [.old, .new], context: nil)
        self.player.addObserver(self, forKeyPath: "rate", options: [.old, .new], context: nil)
        self.player.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.receiveAirPlayNotification(note:)),name: UIScreen.didConnectNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleAVPlayerAccess),name: NSNotification.Name.AVPlayerItemNewAccessLogEntry,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleAVPlayerError),name: NSNotification.Name.AVPlayerItemNewErrorLogEntry,
                                               object: nil)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(AVPlayerViewWillDisappear), name: NSNotification.Name.nwAVPlayerViewControllerDismissingNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didOrientationChange(_:)), name: UIDevice.orientationDidChangeNotification, object: nil)

        
        if let _ = UserDefaults.standard.string(forKey: "viewer_id") {
            
        }
        else {
            let viewer_id = UUID().uuidString
            UserDefaults.standard.setValue(viewer_id, forKey: "viewer_id")
        }
        
        
        let url: URL? = (player.currentItem?.asset as? AVURLAsset)?.url
        let video_url = url!.absoluteString
        
        var device_category :String = ""
        var device_is_touchscreen :Bool = true
        let operating_system_version = UIDevice.current.systemVersion
        let device_name = UIDevice.current.name
        let operating_system = UIDevice.current.systemName
        switch UIDevice.current.userInterfaceIdiom.rawValue
        {
            case   0:
                device_category = "iPhone"
                device_is_touchscreen = true
                break
            case 1:
                device_category = "iPad"
                device_is_touchscreen = true
                break
            case 2:
                device_category = "TV"
                device_is_touchscreen = false
                break
            case 3:
                device_category = "carPlay"
                device_is_touchscreen = true
                break
            case 4:
                device_category = "Mac"
                device_is_touchscreen = false
                break
            default:
                device_category = "Unspecified"
                device_is_touchscreen = true
                break
        }
        let device_manufacturer = "apple"
        //        let screenScale = UIScreen.main.scale
        //        let device_display_ppi = Float(screenScale)
        //        meta_device_Arch = getArchitecture()
        //        meta_CDN = getHostName(videoUrl: video_url)
        //        videoSourceUrl = video_url
        
        
        UserDefaults.standard.setValue(device_category, forKey: "user_agent")
        let dataManager = DataManager()
        
        // API 1 - Before Playing
        
        APIService.validateAPIRequest(hash_id: dataManager.hashID(), videoURL: video_url, completion: { isValid in
            if !isValid {
                self.player.pause()
            }
        })
        
        
    }
    @objc func didOrientationChange(_ notification: Notification) {
            //const_pickerBottom.constant = 394
            print("other")
            switch UIDevice.current.orientation {
                case .landscapeLeft, .landscapeRight:
                    print("landscape")
                    self.isProtrait = false
                case .portrait, .portraitUpsideDown:
                    print("portrait")
                    self.isProtrait = true
                default:
                    print("other")
            }
        
            UpdateViewCount()
    
        }
    
    @objc func AVPlayerViewWillDisappear() {
        timer?.invalidate()
        timer = nil
        timerViewCount?.invalidate()
        timerViewCount = nil
    }
    
    
    //MARK:- Update View Count
    @objc func UpdateViewCount()
    {
        let eventHandler = EventHandler()
        let dataManager = DataManager()

           eventHandler.showcvAPICall() { count in
            DispatchQueue.main.async {
                
       
                
                self.label.removeFromSuperview()
                self.label.text = "\(self.count)"
                self.label.layer.backgroundColor  = UIColor.red.cgColor
                self.label.layer.cornerRadius = 11
                self.label.layer.masksToBounds = true
                self.label.textColor = UIColor.white
                self.label.sizeToFit()
                self.label.textAlignment = .center;
            self.count = count
            self.label.text = "\(self.count)"
            
            if dataManager.showcv() {
                
                if let playerViewController = self.controller {
                    playerViewController.contentOverlayView?.addSubview(self.label)
                    playerViewController.contentOverlayView?.addSubview(self.label)
                    playerViewController.view.bringSubviewToFront(self.label)
                    if self.isProtrait {
                        self.label.frame = CGRect(x: 80, y: playerViewController.view.bounds.size.height - 79, width: 50, height: 22)
                    } else {
                        self.label.frame = CGRect(x: 95, y: playerViewController.view.bounds.size.height - 79, width: 50, height: 22)
                        
                    }
                    
                }
                else if let playerViewController = UIApplication.shared.windows.first?.rootViewController?.presentedViewController as? AVPlayerViewController {
                    playerViewController.contentOverlayView?.addSubview(self.label)
                    playerViewController.contentOverlayView?.addSubview(self.label)
                    playerViewController.view.bringSubviewToFront(self.label)
                    
                    if self.isProtrait {
                        self.label.frame = CGRect(x: 80, y: playerViewController.view.bounds.size.height - 79, width: 50, height: 22)
                    } else {
                        self.label.frame = CGRect(x: 95, y: playerViewController.view.bounds.size.height - 79, width: 50, height: 22)
                        
                    }
                    
                }
            }
        }
            }
        
        
    }
    
    //MARK:- Player Data
    func callPlayerData(_ gumletEnvironmentKey:String, playerAV:AVPlayer, videoUrl:String)
   {
        //callIds()
//        playerInstanceId = UserDefaults.standard.value(forKey: "playerInstanceId") as! String
//        let screenBounds = getScreenBounds()
//        screenWidth = Int(screenBounds.size.width)
//        screenHeight = Int(screenBounds.size.height)
//        let language = NSLocale.preferredLanguages.first
//        if ((language) != nil) {
//                playerLanguage  = language!
//        }
//        else
//        {
//            playerLanguage  = "English"
//        }
//        deviceOrientation = "Portrait"//rotated()
//        UserDefaults.standard.setValue(deviceOrientation, forKey: "deviceOrientation")
//        let isPreload = "true"
//        let bundleId = Bundle.main.bundleIdentifier!
//        let playerSoftware =  "AVPlayer"
//        let PlayerSoftwareVersion = "AVKit"
//        currentTimeEpoch = (((Date().timeIntervalSince1970) * 1000)/1000).roundToDecimal(3)
////        let playerData = customerPlayerData
////        let pageType = playerData.gumletPageType
////        let playerIntegrationVersion = playerData.GumletPlayerIntegrationVersion
////        let playerName = playerData.GumletPlayerName
//       APIService.validateAPIRequest(hash_id: "", videoURL: "", completion: {_ in
//
//       })
    }
  
    
    //MARK:  Events API
    func callEventAPI(eventTime : Double, previousEvents:String, eventName:String)
    {
        
        
    }
    
    //MARK:- get play and pause time
   public func getPlay_Pause_Time() -> Double
    {
        let currentTime = player.currentTime()
        let time = CMTimeGetSeconds(currentTime)
        let minutString = time / 60
        let playTimeInMS = (time * 1000.0).roundToDecimal(2)
        return playTimeInMS
    }
    
    //MARK:- Device Data
    private func getArchitecture() -> String {
        let info = NXGetLocalArchInfo()
        let device_Arch =  NSString(utf8String: (info?.pointee.name)!)
        return device_Arch! as String
    }
    
    //MARK:-- get video file Extension
    func getVideoSourceType(VideoUrl:String)->String
    {
        let filename: NSString = VideoUrl as NSString
        let pathExtention = filename.pathExtension
        return pathExtention
    }
    
    //MARK:--- get host name
    func getHostName(videoUrl:String) -> String
    {
        var domain :String = ""
        if  let url = URL(string: videoUrl)
        {
            domain = url.host!
        }
        return domain
    }
    
    //MARK:- calculate previous event time
    func getLastEventsTime()-> Float
    {
        var prevTime : Int = 0
        let prevEventTime = UserDefaults.standard.value(forKey: "localCurrentTimePrevEvent")as! String
        if prevEventTime == "0"
        {
        }
        else
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"//this your string date format
            dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
            let dated = dateFormatter.date(from: prevEventTime )
            prevTime = Int(dated!.timeIntervalSince1970 * 1000)
        }
     
        let localCurrentTimeEvent = UserDefaults.standard.value(forKey: "localCurrentTime")as! String
        let dFormatter = DateFormatter()
        dFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"//this your string date format
        dFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let dated1 = dFormatter.date(from: localCurrentTimeEvent)
        let lTime = Int(dated1!.timeIntervalSince1970 * 1000)
        let diff = lTime - prevTime
        UserDefaults.standard.setValue(localCurrentTimeEvent, forKey: "localCurrentTimePrevEvent")
        return Float(diff)
    }
    
    //MARK:- get total video duration
    public func getTotalVideoDuration() -> Double
    {
        let seconds = (player.currentItem?.asset.duration)
        let  video_total_time = CMTimeGetSeconds(seconds!)
        let videoTotalDuration = video_total_time * 1000
        
        return videoTotalDuration
    }
    
    //MARK:-- get Upscale
    public func upScale(playerWidth:Float,videoWidth:Float) -> Float
    {
        //playerwidth high and videoWidth less , means expand video width as per player width
        var upScale : Float = 0.0
        if (playerWidth > videoWidth)
        {
            upScale = (abs((playerWidth - videoWidth)/videoWidth)*100)
        }
        else{
            upScale = 0.0
        }
        return upScale
    }
    
    //MARK:-- get downScale
    public func downScale(playerWidth:Float,videoWidth:Float) -> Float
    {
        //playerwidth less and videoWidth high , means  compress video width as per player width
        var downScale : Float = 0.0
        if (playerWidth < videoWidth)
        {
            downScale = (abs((playerWidth - videoWidth)/videoWidth)*100)
        }
        else{
            downScale = 0.0
        }
        return downScale
    }
    
    //MARK:-- get date
    func getDate() -> String
    {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        df.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let dateString = df.string(from: date)
        return dateString
    }
    
    //MARK:-- get current Time in Epoch
    public func currentEpochTime() -> Double
    {
        return (((Date().timeIntervalSince1970) * 1000)/1000).roundToDecimal(3)
    }
    
    //MARK:-- get current Playhead Time in Ms
    func getCurrentPlayheadTimeMs() -> Double {
        return CMTimeGetSeconds(player.currentTime()) * 1000;
    }
    
    
    //set the timer, which will update your progress bar. You can use whatever time interval you want
    //MARK:--  calculate Bandwidth Metric
    func calculateBandwidthMetricFromAccessLog(log:AVPlayerItemAccessLog)
    {
        /*
        if isplaybackFinish == false{
            if log != nil && log.events.count > 0
            {
                //https://developer.apple.com/documentation/avfoundation/avplayeritemaccesslogevent?language=objc
                let event : AVPlayerItemAccessLogEvent? = log.events[log.events.count - 1]
                if (_lastTransferEventCount != log.events.count) {
                    _lastTransferDuration = 0
                    _lastTransferredBytes = 0
                    _lastTransferEventCount = Int8(log.events.count);
                }
                let request_start = Int(Date().timeIntervalSince1970)
                let request_response_start = Int(Date().timeIntervalSince1970)
                let request_response_end  = Int(Date().timeIntervalSince1970)//(requestCompletedTime * 1000)
                let request_bytes_loaded :Int64 =  Int64(event!.numberOfBytesTransferred) - (_lastTransferredBytes)
                let request_type = "event_requestcompleted"
                let request_response_headers = "";
                var requestHostName :String? = ""
                if event?.uri != nil
                {
                    requestHostName =  getHostName(videoUrl:(event?.uri)!)
                }
                else{
                    requestHostName = ""
                }
                let requestMediaDuration :Int = Int(event!.segmentsDownloadedDuration)
                _lastTransferredBytes = Int64(event!.numberOfBytesTransferred);
                _lastTransferDuration = event!.transferDuration;
//                callNetworkAPI(requestStart: request_start, requestrResponseStart: request_response_start, requestResponseEnd: request_response_end, requestType: request_type, requestHostName: requestHostName!, requestBytesLoaded: request_bytes_loaded, requestResponseHeaders: request_response_headers, requestMediaDuration_millis: requestMediaDuration, errorCode: 200, error: "", errorText: "Success")
            }
        }
        else if isplaybackFinish == true{
            if log != nil && log.events.count > 0
            {
                //https://developer.apple.com/documentation/avfoundation/avplayeritemaccesslogevent?language=objc
                let event : AVPlayerItemAccessLogEvent? = log.events[log.events.count - 1]
                if (_lastTransferEventCount != log.events.count) {
                    _lastTransferDuration = 0
                    _lastTransferredBytes = 0
                    _lastTransferEventCount = Int8(log.events.count);
                }
                let request_start = Int(Date().timeIntervalSince1970)//getDate()
                let request_response_start = Int(Date().timeIntervalSince1970)//getDate()
                let request_response_end  = Int(Date().timeIntervalSince1970)
                let request_bytes_loaded :Int64 =  Int64(event!.numberOfBytesTransferred) - (_lastTransferredBytes)
                let request_type = "event_requestcanceled"
                let request_response_headers = "";
                var requestHostName :String? = ""
                if requestHostName != nil{
                    requestHostName =  getHostName(videoUrl:(event?.uri)!)
                }
                else{
                    requestHostName = ""
                }
                let requestMediaDuration :Int = Int(event!.segmentsDownloadedDuration)
               _lastTransferredBytes = Int64(event!.numberOfBytesTransferred);
                _lastTransferDuration = event!.transferDuration;
//                callNetworkAPI(requestStart: request_start, requestrResponseStart: request_response_start, requestResponseEnd: request_response_end, requestType: request_type, requestHostName: requestHostName!, requestBytesLoaded: request_bytes_loaded, requestResponseHeaders: request_response_headers, requestMediaDuration_millis: requestMediaDuration, errorCode: 200, error: "", errorText: "Success")
            }
        }
        */
    }
    
    //MARK:--  check Video Quality Change
    func checkVideoQualityChange()
    {
//        let videoH  = UserDefaults.standard.value(forKey: "videoHeight") as! Float
//        let videoW = UserDefaults.standard.value(forKey: "videoWidth") as! Float
//        let size = getVideoResolution()
//        if videoW  != Float(abs(size!.width)).rounded() && videoH != Float(abs(size!.height)).rounded()
//        {
//            if (isVideoQualityChange == false)
//            {
//              //  callVideoQualityChange()
//            }
//        }
//        else
//        {
//            if isVideoQualityChange == true
//            {
//               isVideoQualityChange = false
//            }
//        }
    }
    
    //MARK:--  check Mute And Unmute
    func checkMuteAnUnmute()
    {
        //let eventHandler = EventHandler()
        //eventHandler.playerCore = self
//        if videoMuted == false {
//            if player.isMuted == true
//            {
//                play_current_time = getPlay_Pause_Time()
//                let currentStates = UserDefaults.standard.value(forKey: "currentState") as! String
//                //eventHandler.callMute(currentState: currentStates, playCurrentTime: play_current_time)
//                videoMuted = true
//            }
//        }
//        else if player.isMuted == false
//        {
//            if videoUnMuted == true
//            {
//               play_current_time = getPlay_Pause_Time()
//                let currentStates = UserDefaults.standard.value(forKey: "currentState") as! String
//               // eventHandler.callUnmute(currentState: currentStates, playCurrentTime: play_current_time)
//                videoUnMuted = false
//            }
//        }
    }
        
    //MARK:--  update Last Playhead Time
    func updateLastPlayheadTime() {
//        lastUpdateTime = Float(getCurrentPlayheadTimeMs())
//        timeOfUpdate = CFAbsoluteTimeGetCurrent()
    }
    
    //MARK:--  update Last Playhead Time for test
    public func getPreviousEventName() -> String
    {
        guard let prevEvent = UserDefaults.standard.string(forKey:"previousEvents") else { return  ""}
        return prevEvent
    }
    
    //MARK:--  update Last Playhead Time for test
    public func getPreviousTime() -> Int
    {
        let previousTime = UserDefaults.standard.integer(forKey: "previousEventTime")
        return previousTime
    }
    
    //MARK:-- de init
    deinit
    {
        UserDefaults.standard.removeObject(forKey: "video_url")
        UserDefaults.standard.removeObject(forKey: "playBackId")
        UserDefaults.standard.removeObject(forKey: "playerInstanceId")
    }
}
private enum NWPlayerState: String {
    case initiate = "initiate"
    case error = "error"
    case ready = "ready"
    case buffering = "buffering"
    case play = "play"
    case playing = "playing"
    case paused = "paused"
    case end = "end"
}
// create an extension of AVPlayerViewController
extension AVPlayerViewController {
    // override 'viewWillDisappear'
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // now, check that this ViewController is dismissing
        if self.isBeingDismissed == false {
            return
        }

        // and then , post a simple notification and observe & handle it, where & when you need to.....
        NotificationCenter.default.post(name: .nwAVPlayerViewControllerDismissingNotification, object: nil)
    }
}

extension Notification.Name {
static let nwAVPlayerViewControllerDismissingNotification = Notification.Name.init("nwplayerdismissing")
}
