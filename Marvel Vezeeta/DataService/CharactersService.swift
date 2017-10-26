//
//  CharactersService.swift
//  Marvel Vezeeta
//
//  Created by Mahmoud Hamad on 10/21/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class CharactersService {
    
    static var instance = CharactersService()
    
    func fetchCharacters(limit: Int,offSet: Int, completion: @escaping ([Character]) -> ()) {
        
        let ts = NSDate().timeIntervalSince1970.description
        let hash = "\(ts)\(PRIVATE_KEY)\(PUBLIC_KEY)".encriptToMD5().map { String(format: "%02hhx", $0) }.joined()
        //md5Hex: .map { String(format: "%02hhx", $0) }.joined()
        //md5Base64: .base64EncodedString()
        
        
        /*https://gateway.marvel.com:443/v1/public/characters?limit=10&offset=0&apikey=3000769f46072b194805b46107b89562&ts=1508624633.62784&hash=be230ecbb4cfb09047b361f3964f1fc6*/

        let url = "\(CHARACTERS_BASE_URL)?limit=\(limit)&offset=\(offSet)&apikey=\(PUBLIC_KEY)&ts=\(ts)&hash=\(hash)"
        
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
