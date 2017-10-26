//
//  String+MD5.swift
//  Marvel Vezeeta
//
//  Created by Mahmoud Hamad on 10/21/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import Foundation


extension String {
    func encriptToMD5() -> Data {
        let messageData = self.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData
    }
}
