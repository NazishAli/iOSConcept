//
//  Collection+Extension.swift
//  Swifterviewing
//
//  Created by Nazish Ali on 02/02/22.
//  Copyright © 2022 World Wide Technology Application Services. All rights reserved.
//

import Foundation


extension Dictionary {
    
    mutating func appendDictionary(new: Dictionary) {
        for (key, value) in new {
            self.updateValue(value, forKey: key)
        }
    }
}
