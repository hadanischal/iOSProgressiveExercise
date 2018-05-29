//
//  Utility.swift
//  iOSProgressiveExercise
//
//  Created by Nischal Hada on 5/29/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

protocol Utility{
    func filterNil(_ value : AnyObject?) -> AnyObject?
}

class Util {
    
}

extension Util: Utility {
    func filterNil(_ value : AnyObject?) -> AnyObject? {
        if value is NSNull || value == nil {
            return "" as AnyObject
        } else {
            return value
        }
    }
}
