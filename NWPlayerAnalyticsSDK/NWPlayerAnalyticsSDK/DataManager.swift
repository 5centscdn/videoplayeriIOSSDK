//
//  DataManager.swift
//  NWPlayerAnalyticsSDK
//
//  Created by Mamun Ar Rashid on 10/7/23.
//

import Foundation

class DataManager {
    
     func checkSessionId() -> String
     {
         if let session_id = UserDefaults.standard.string(forKey: "user_session") {
             return session_id
         }
         else {
             return "4gpuj6i3znoio7r4"
         }
     }
     
      func hashID() -> String
      {
          if let hashID = UserDefaults.standard.string(forKey: "hash_id") {
              return hashID
          }
          else {
              return ""
          }
      }
    
    func viewerID() -> String
    {
        if let viewer_id = UserDefaults.standard.string(forKey: "viewer_id") {
            return viewer_id
        }
        else {
            return ""
        }
    }
    
    func viewID() -> String
    {
        if let view_id = UserDefaults.standard.string(forKey: "view_id") {
            return view_id
        }
        else {
            return ""
        }
    }
    
     
      func title() -> String
      {
          if let title = UserDefaults.standard.string(forKey: "title") {
              return title
          }
          else {
              return ""
          }
      }
     
      func tags() -> [String]
      {
          if let tags = UserDefaults.standard.stringArray(forKey: "tags")  {
              return tags
          }
          else {
              return [String]()
          }
      }
    func userAgent() -> String
    {
        if let userAgent = UserDefaults.standard.string(forKey: "user_agent") {
            return userAgent
        }
        else {
            return ""
        }
    }
    
    func initime() -> Int
    {
        return UserDefaults.standard.integer(forKey: "initime")
    }
    
      func pageLoad() -> Int
      {
          return  UserDefaults.standard.integer(forKey: "pageLoad")
      }
    
     public func showcv() -> Bool
      {
          return UserDefaults.standard.bool(forKey: "showcv")
         
      }
    
    public func isvalid() -> Bool
     {
         return UserDefaults.standard.bool(forKey: "isvalid")
        
     }
    
}
