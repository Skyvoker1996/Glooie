//
//  MovementType.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/11/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit
import SwiftyJSON

class MovementType {
    
    enum Types: String {
        
        case jump = "Jumps"
        case position = "Positions"
        case specialMotion = "Special motions"
        case catchLocation = "Locations of ball catch"
        case none
    }
    
    let type: Types
    let image: UIImage?
    let directions: [DirectionNames]
    
    init(json: JSON) {
        
        type = MovementType.Types(rawValue: json["type"].stringValue) ?? .none
        image = UIImage(named: json["image"].stringValue)
        directions = json["directions"].array?.map { DirectionNames(rawValue: $0.stringValue) ?? .none } ?? []
    }
}
