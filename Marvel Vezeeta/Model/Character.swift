//
//  Character.swift
//  Marvel Vezeeta
//
//  Created by Mahmoud Hamad on 10/22/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import Foundation


class Character {
    
    private var _id: Int
    private var _name: String
    private var _thumbNail: String
    
    init(id: Int, name: String, thumbNail: String) {
        self._id = id
        self._name = name
        self._thumbNail = thumbNail
        
    }
    
    var id: Int {
        get {
            return _id
        }
    }
    
    var name: String {
        get {
            return _name
        }
    }
    
    var thumbNail: String {
        get {
            return _thumbNail
        }
    }
}
