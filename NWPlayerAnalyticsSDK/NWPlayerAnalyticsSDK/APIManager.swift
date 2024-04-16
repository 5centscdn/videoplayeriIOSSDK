//
//  APIManager.swift
//  VideoPlayerAnalytics
//
//  Created by Mamun Ar Rashid on 2/7/23.
//

import Foundation

struct APIResult: Codable {
   
    var anchors: [Anchor] = []
    var offset : String?
    
    private enum CodingKeys: String, CodingKey {
        case anchors = "anchors"
        case offset = "offset"
    }
}

struct APIService {
    
    static var urlString: String = "https://collector-videoplayer.5centscdn.net/"
    
    static func validateAPIRequest  (hash_id: String, videoURL:String, completion: @escaping (Bool) -> Void)  {
        
        let url = URL(string: urlString + "v")!
        let data = [
            "hash_id": hash_id,
            "url":videoURL
        ] as [String : Any]
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970 // It is necessary for correct decoding. Timestamp -> Date.
        

        let jsonData = try? JSONSerialization.data(withJSONObject: data)

        // create post request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
  
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    UserDefaults.standard.setValue(true, forKey: "isvalid")
                    return completion(true)
                } else {
                    UserDefaults.standard.setValue(false, forKey: "isvalid")
                    return completion(false)
                }
            }
            
            return completion(false)
            
        }.resume()
    }
    
    static func playAPIRequest  (completion: @escaping (Bool) -> Void)  {
        
        let url = URL(string: urlString + "t")!
        let apiData = DataManager()
        let data = [
            "hash_id": apiData.hashID(),
            "title": apiData.title(),
            "tags": apiData.tags(),
            "viewer_id": apiData.viewerID(),
            "view_id": apiData.viewID(),
            "type":"page_load",
            "user_agent": apiData.userAgent(),
            "referer":"",
            "value1": apiData.pageLoad()
        ] as [String : Any]
        

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970 // It is necessary for correct decoding. Timestamp -> Date.
        

        let jsonData = try? JSONSerialization.data(withJSONObject: data)

        // create post request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
  
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    return completion(true)
                }
            }
            
            return completion(false)
            
        }.resume()
    }


static func impressionAPICall(completion: @escaping (Bool) -> Void)  {
    
    let url = URL(string: urlString + "t")!
    let apiData = DataManager()
    let data = [
        "hash_id": apiData.hashID(),
        "title": apiData.title(),
        "tags": apiData.tags(),
        "viewer_id": apiData.viewerID(),
        "view_id": apiData.viewID(),
        "type":"impression",
        "user_agent": apiData.userAgent(),
        "referer":"",
    ] as [String : Any]
    

    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970 // It is necessary for correct decoding. Timestamp -> Date.
    

    let jsonData = try? JSONSerialization.data(withJSONObject: data)

    // create post request
    var request = URLRequest(url: url)
    request.httpMethod = "POST"

    // insert json data to the request
    request.httpBody = jsonData
    
    URLSession.shared.dataTask(with: request) { data, response, error in

        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 200 {
                return completion(true)
            }
        }
        
        return completion(false)
        
    }.resume()
}
    
    static func playerLoadAPICall(completion: @escaping (Bool) -> Void)  {
        
        let url = URL(string: urlString + "t")!
        let apiData = DataManager()
        let data = [
            "hash_id": apiData.hashID(),
            "title": apiData.title(),
            "tags": apiData.tags(),
            "viewer_id": apiData.viewerID(),
            "view_id": apiData.viewID(),
            "type":"player_load",
            "user_agent": apiData.userAgent(),
            "referer":"",
            "value1": apiData.initime()
        ] as [String : Any]
        

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970 // It is necessary for correct decoding. Timestamp -> Date.
        

        let jsonData = try? JSONSerialization.data(withJSONObject: data)

        // create post request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    return completion(true)
                }
            }
            
            return completion(false)
            
        }.resume()
    }
    
    
    static func playAPICall(completion: @escaping (Bool) -> Void)  {
        
        let url = URL(string: urlString + "t")!
        let apiData = DataManager()
        let data = [
            "hash_id": apiData.hashID(),
            "title": apiData.title(),
            "tags": apiData.tags(),
            "viewer_id": apiData.viewerID(),
            "view_id": apiData.viewID(),
            "type":"play",
            "user_agent": apiData.userAgent(),
            "referer":""
        ] as [String : Any]
        

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970 // It is necessary for correct decoding. Timestamp -> Date.
        

        let jsonData = try? JSONSerialization.data(withJSONObject: data)

        // create post request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    return completion(true)
                }
            }
            
            return completion(false)
            
        }.resume()
    }
    
    static func engagementAPICall(completion: @escaping (Bool) -> Void)  {
        
        let url = URL(string: urlString + "t")!
        let apiData = DataManager()
        let data = [
            "hash_id": apiData.hashID(),
            "title": apiData.title(),
            "tags": apiData.tags(),
            "viewer_id": apiData.viewerID(),
            "view_id": apiData.viewID(),
            "type":"engagement",
            "user_agent": apiData.userAgent(),
            "referer":""
        ] as [String : Any]
        

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970 // It is necessary for correct decoding. Timestamp -> Date.
        

        let jsonData = try? JSONSerialization.data(withJSONObject: data)

        // create post request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    return completion(true)
                }
            }
            
            return completion(false)
            
        }.resume()
    }
    
    static func playbackCompleteAPICall(completion: @escaping (Bool) -> Void)  {
        
        let url = URL(string: urlString + "t")!
        let apiData = DataManager()
        let data = [
            "hash_id": apiData.hashID(),
            "title": apiData.title(),
            "tags": apiData.tags(),
            "viewer_id": apiData.viewerID(),
            "view_id": apiData.viewID(),
            "type":"complete",
            "user_agent": apiData.userAgent(),
            "referer":""
        ] as [String : Any]
        

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970 // It is necessary for correct decoding. Timestamp -> Date.
        

        let jsonData = try? JSONSerialization.data(withJSONObject: data)

        // create post request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    return completion(true)
                }
            }
            
            return completion(false)
            
        }.resume()
    }
    static func pullAPICall(completion: @escaping (Bool) -> Void)  {
        
        let url = URL(string: urlString + "t")!
        let apiData = DataManager()
        let data = [
            "hash_id": apiData.hashID(),
            "title": apiData.title(),
            "tags": apiData.tags(),
            "viewer_id": apiData.viewerID(),
            "view_id": apiData.viewID(),
            "type":"engagement",
            "user_agent": apiData.userAgent(),
            "referer":"",
            "value1":10,
            "value2":10
        ] as [String : Any]
        

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970 // It is necessary for correct decoding. Timestamp -> Date.
        

        let jsonData = try? JSONSerialization.data(withJSONObject: data)

        // create post request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    return completion(true)
                }
            }
            
            return completion(false)
            
        }.resume()
    }
    
    static func showcvAPICall(completion: @escaping (Int) -> Void)  {
        
        let apiData = DataManager()
        let url = URL(string: urlString + "c?"+"hash_id="+apiData.hashID())!
      
        
        // create post request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in

            if let httpResponse = response as? HTTPURLResponse, let data = data {
                if httpResponse.statusCode == 200 {
                    
                    do {
                        // make sure this JSON is in the format we expect
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            // try to read out a string array
                            if let count = json["count"] as? Int {
                                print(count)
                                return completion(count)
                            }
                        }
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                    
                  
                    return completion(0)
                }
            }
            
            return completion(0)
            
        }.resume()
    }

}






struct Anchor: Codable {
    let id: Int?
    let email: String?
    let type: String?
    let role: String?
    let fullname: String?
    let mobile: String?
    let company: String?
    let gender: String?
    let salesmanid: Int?
    let Table: String?
    let password: String?
    let retypepassword: String?
}

struct LoginToken: Codable {
    let AccessToken: String?
    let RefreshToken: String?
    let AccessUUID: String?
    let RefreshUUID: String?
    let AtExpires: UInt64?
    let RtExpires: UInt64?
}
