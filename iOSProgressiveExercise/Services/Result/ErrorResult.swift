//
//  ErrorResult.swift
//  iOSProgressiveExercise
//
//  Created by Nischal Hada on 5/29/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}
