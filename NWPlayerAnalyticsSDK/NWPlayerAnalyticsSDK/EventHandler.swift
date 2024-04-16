//
//  EventHandler.swift
//  NWPlayerAnalyticsSDK
//
//  Created by Mamun Ar Rashid on 10/7/23.
//

import Foundation

class  EventHandler {
    
    func allEventsAfterPlay() {
        

//        API 2.2 - on 2.1 success
//        API 2.3 - right after 2.1
//        API 2.4 - right after 2.2
//        API 2.5 - on 2.4 success
        
        APIService.playerLoadAPICall(completion: {_ in
            
        })
        
        APIService.playAPICall(completion: {_ in
            
        })
        
        APIService.impressionAPICall(completion: {_ in
            
        })
        APIService.engagementAPICall(completion: {_ in
            
        })
        
   
        
    }
    
    func showcvAPICall(completion: @escaping (Int) -> Void) {
        
        APIService.showcvAPICall(completion: { count in
            completion(count)
        })
    }
    
    func playEvent() {
        //        API 2.1 - On play event
        APIService.playAPIRequest(completion: {_ in
            
        })
    }
    
    func playCompleteEvent() {
        
        //API 4 - on playback completed
        APIService.playbackCompleteAPICall(completion: {_ in
            
        })
    }
    
    func pullEvery10SEvent() {
        //API 3.1 - every 10/30 seconds while the content is being played
        APIService.pullAPICall(completion: {_ in
            
        })
    }
   
    
    
}
