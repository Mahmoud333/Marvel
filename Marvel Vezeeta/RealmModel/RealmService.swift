//
//  RealmService.swift
//  Marvel Vezeeta
//
//  Created by Mahmoud Hamad on 11/5/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class RealmService {
    
    static var instace = RealmService()
    
    var realm: Realm? //use it for Query and Save

    //var realmCharacters = [RealmCharacter]()
    
    
    init() {
        do {
            realm = try Realm() //use it for Query and Save
        } catch let err {
            print("catch error: \(err.localizedDescription)")
        }
    }
    
    func fetchRealmCharacters() -> [Character]{
        let realmCharacters = realm?.objects(RealmCharacter.self)
        var characters = [Character]()
        
        for realmCharacter in realmCharacters! {
            let character = Character(id: realmCharacter.id, name: realmCharacter.name, thumbNail: realmCharacter.imageURL)
            
            characters.append(character)
        }
        return characters
    }
    
    func saveThisCharacter(character: Character){
        let realmCharacter = RealmCharacter()
        realmCharacter.id = character.id
        realmCharacter.name = character.name
        realmCharacter.imageURL = character.thumbNail
        
        //Save Data 😅
        let imageView = UIImageView()
        let url = URL(string: character.thumbNail)
        imageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (image, error, chacheType, url) in
            
            let data = UIImageJPEGRepresentation(image!, 1.0)  //imageView.image
            realmCharacter.data = data
            
            try! self.realm?.write {
                self.realm?.add(realmCharacter)
            }
            
        }
    }
    
    func saveThis(characters: [Character]){
        var willSave = [RealmCharacter]()
        
        for character in characters {
            
            let realmCharacter = RealmCharacter()
            realmCharacter.id = character.id
            realmCharacter.name = character.name
            realmCharacter.imageURL = character.thumbNail
            
            //Save Data 😅
            let imageView = UIImageView()
            let url = URL(string: character.thumbNail)
            imageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, url) in
                
                let data = UIImageJPEGRepresentation(image!, 1.0)  //imageView.image
                realmCharacter.data = data
                willSave.append(realmCharacter)
            })
            
            
            //way to get image
            /*
            Alamofire.request(character.thumbNail).responseData { (response) in
                print(response)
                if let data = response.value {
                    realmCharacter.data = data
                    willSave.append(realmCharacter)
                }
            }*/
        }
        
        //save realm
        try! self.realm?.write {
            self.realm?.add(willSave)
        }
    }
    
}
