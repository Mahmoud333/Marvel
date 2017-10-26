//
//  CharacterDetails.swift
//  Marvel Vezeeta
//
//  Created by Mahmoud Hamad on 10/23/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import Foundation
import SwiftyJSON

class CharacterDetails {
    
    private var _id: Int!
    private var _name: String!
    private var _thumbNail: String!
    private var _description: String!
    
    private var _comicsItems = [Item]()
    private var _seriesItems = [Item]()
    private var _storiesItems = [Item]()
    private var _eventsItems = [Item]()

    
    func initWithData(data: Any) {
        let json = JSON(data)

        print("id: \(json["data"]["results"][0]["id"].intValue)")
        
        
        self._id = json["data"]["results"][0]["id"].intValue
        self._name = json["data"]["results"][0]["name"].stringValue
        self._description = json["data"]["results"][0]["description"].stringValue
        
        let thmbNail = "\(json["data"]["results"][0]["thumbnail"]["path"]).\(json["data"]["results"][0]["thumbnail"]["extension"])"
        self._thumbNail = thmbNail
        
        
        let comicsItemsJSON = json["data"]["results"][0]["comics"]["items"].arrayValue
        for item in comicsItemsJSON {
            let uri = item["resourceURI"].stringValue
            let name = item["name"].stringValue
            let item = Item(resourceURI: uri, name: name)
            self._comicsItems.append(item)
        }
        
        let seriesItemsJSON = json["data"]["results"][0]["series"]["items"].arrayValue
        for item in seriesItemsJSON {
            let uri = item["resourceURI"].stringValue
            let name = item["name"].stringValue
            let item = Item(resourceURI: uri, name: name)
            self._seriesItems.append(item)
        }
        
        let storiesItemsJSON = json["data"]["results"][0]["stories"]["items"].arrayValue
        for item in storiesItemsJSON {
            let uri = item["resourceURI"].stringValue
            let name = item["name"].stringValue
            let item = Item(resourceURI: uri, name: name)
            print("uri: \(uri), name: \(name)")

            self._storiesItems.append(item)
        }
        
        let eventsItemsJSON = json["data"]["results"][0]["events"]["items"].arrayValue
        for item in eventsItemsJSON {
            let uri = item["resourceURI"].stringValue
            let name = item["name"].stringValue
            let item = Item(resourceURI: uri, name: name)
            self._eventsItems.append(item)
        }
        
        print("_storiesItems: \(_storiesItems)")
    }
    
    
    
    var id: Int {
        get {
            if _id == nil { return 0}
            return _id
        }
    }
    var name: String{
        get {
            if _name == nil { return ""}
            return _name
        }
    }
    var thumbNail: String{
        get {
            if _thumbNail == nil { return ""}
            return _thumbNail
        }
    }
    var description: String{
        get {
            if _description == nil { return ""}
            return _description
        }
    }

    var comicsItems: [Item]{
        get {
            return _comicsItems
        }
    }
    var seriesItems: [Item]{
        get {
            return _seriesItems
        }
    }
    var storiesItems: [Item]{
        get {
            return _storiesItems
        }
    }
    var eventsItems: [Item]{
        get {
            return _eventsItems
        }
    }



}








struct Item {
    var resourceURI: String
    var name: String
}
