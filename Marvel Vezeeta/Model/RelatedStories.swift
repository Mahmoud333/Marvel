//
//  RelatedStories.swift
//  Marvel Vezeeta
//
//  Created by Mahmoud Hamad on 10/24/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import Foundation
import SwiftyJSON


class RelatedStories {
    
    private var _thumbNail: String!
    private var _title: String!
    private var _description: String!
    
    func initReturnWithData(data: Any) -> [RelatedStories] {
        var allStories = [RelatedStories]()
        
        let json = JSON(data)
        
        print("title: \(json["data"]["results"][0]["title"].stringValue)")
        
        let arrayStoryJSON = json["data"]["results"].arrayValue
        
        for story in arrayStoryJSON {
            
            let relatedStory = RelatedStories()
            
            let thumbNail = "\(story["thumbnail"]["path"]).\(story["thumbnail"]["extension"])"
            relatedStory._thumbNail = thumbNail
            
            relatedStory._title = story["title"].stringValue
            
            relatedStory._description = story["description"].stringValue
            
            allStories.append(relatedStory)
        }
        
        return allStories
    }
    
    var thumbNail: String {
        get {
            if _thumbNail == nil {return ""}
            return _thumbNail
        }
    }
    var title: String {
        get {
            if _title == nil {return ""}
            return _title
        }
    }
    var description: String {
        get {
            if _description == nil {return ""}
            return _description
        }
    }
}
