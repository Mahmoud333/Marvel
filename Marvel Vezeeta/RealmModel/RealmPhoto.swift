//
//  RealmPhoto.swift
//  Marvel Vezeeta
//
//  Created by Mahmoud Hamad on 11/5/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import Foundation
import RealmSwift

class RealmPhoto: Object {
    @objc dynamic var data: Data? = nil
    @objc dynamic var imageURL: String = ""
}
