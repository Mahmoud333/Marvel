//
//  SearchService.swift
//  Marvel Vezeeta
//
//  Created by Mahmoud Hamad on 10/24/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SearchService {
    
    static var instance = SearchService()
    
    func fetchHerosWithThis(string: String,limit: Int, completion: @escaping ([Character]) -> ()) {
        
        let ts = NSDate().timeIntervalSince1970.description
        let hash = "\(ts)\(PRIVATE_KEY)\(PUBLIC_KEY)".encriptToMD5().map { String(format: "%02hhx", $0) }.joined()

        
        /*https://gateway.marvel.com:443/v1/public/characters?nameStartsWith=a&limit=3&apikey=3000769f46072b194805b46107b89562*/
        
        let url = "\(CHARACTERS_BASE_URL)?nameStartsWith=\(string)&limit=\(limit)&apikey=\(PUBLIC_KEY)&ts=\(ts)&hash=\(hash)"
        
        print("hash: \(hash)")
        print("URL: " + url)
        
        Alamofire.request(url).responseJSON { (response) in
            
            //print(response.value)
            
            var newCharacters = [Character]()
            
            let jsonData = JSON(response.value)
            let characterArr = jsonData["data"]["results"].arrayValue
            
            for character in characterArr {
                
                let id = character["id"].intValue
                let name = character["name"].stringValue
                
                let thumbNailPath = character["thumbnail"]["path"].stringValue
                let thumbNailExten = character["thumbnail"]["extension"].stringValue
                let thumbNail = "\(thumbNailPath).\(thumbNailExten)"
                
                let character = Character(id: id, name: name, thumbNail: thumbNail)
                
                newCharacters.append(character)
                
            }
            
            completion(newCharacters)
        }
    }
    
}
