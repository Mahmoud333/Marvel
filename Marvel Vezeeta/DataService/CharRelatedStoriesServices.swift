//
//  CharacterRelatedStoriesServices.swift
//  Marvel Vezeeta
//
//  Created by Mahmoud Hamad on 10/24/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import Foundation
import Alamofire

class CharRelatedStoriesServices {
    
    static var instance = CharRelatedStoriesServices()
    
    
    func fetchRelated(id: Int,type: String, completion: @escaping ([RelatedStories]) -> ()) {
        
        let ts = NSDate().timeIntervalSince1970.description
        let hash = "\(ts)\(PRIVATE_KEY)\(PUBLIC_KEY)".encriptToMD5().map { String(format: "%02hhx", $0) }.joined()

        //"https://gateway.marvel.com:443/v1/public/characters/1011334/events?apikey=3000769f46072b194805b46107b89562"
        
        let url = "\(CHARACTERS_BASE_URL)/\(id)/\(type)?&apikey=\(PUBLIC_KEY)&ts=\(ts)&hash=\(hash)"
        
        print("hash: \(hash)")
        print("URL: " + url)
        
        
        Alamofire.request(url).responseJSON { (response) in
            //print(response.value)
            
            //let jsonData = JSON()
            
            
            var relatedStories = RelatedStories().initReturnWithData(data: response.result.value)//initWithData(data: response.result.value)
            
            
            completion(relatedStories)
        }
    }
    
    
    
}
