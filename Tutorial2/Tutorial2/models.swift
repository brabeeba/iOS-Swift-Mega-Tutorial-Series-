//
//  models.swift
//  Tutorial2
//
//  Created by Brabeeba Wang on 8/21/15.
//  Copyright (c) 2015 Brabeeba Wang. All rights reserved.
//

import Foundation
import SwiftyJSON

final class ThreeNumber: ResponseCollectionSerializable, ResponseObjectSerializable {
    var bottom: Int
    var left: Int
    var right: Int
    init?(response: NSHTTPURLResponse, representation: JSON) {
        bottom = representation["bottom"].intValue
        left = representation["left"].intValue
        right = representation["right"].intValue
    }
    static func collection(#response: NSHTTPURLResponse, representation: JSON) -> [ThreeNumber] {
        var results: [ThreeNumber] = []
        
        
        for (index: String, subJson: JSON) in representation["result"] {
            results.append(ThreeNumber(response: response, representation: subJson)!)
        }
        
        
        return results
    }
}

