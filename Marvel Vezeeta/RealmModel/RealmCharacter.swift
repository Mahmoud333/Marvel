//
//  RealmCharacter.swift
//  Marvel Vezeeta
//
//  Created by Mahmoud Hamad on 11/5/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCharacter: Object {
    
    @objc dynamic var imageURL: String = ""
    @objc dynamic var data: Data? = nil
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""

    override static func primaryKey() ->String? {
        return "id"
    }
    

}
