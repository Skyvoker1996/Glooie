//
//  Movement.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/11/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import SceneKit
import SwiftyJSON

class Movement {
    
    let name: String
    let duration: Measurement<UnitDuration>
    let movementType: MovementType.Types
    let animationName: AnimationNames
    let isMovable: Bool
    let transition: SCNVector3?
    let direction: DirectionNames?
    let amountOfFrames: Double
    let compatibleMovements: [String]
    
    init(json: JSON) {
        
        name = json["name"].stringValue
        amountOfFrames = json["amountOfFrames"].doubleValue
        movementType = MovementType.Types(rawValue: json["movementType"].stringValue) ?? .none
        duration = Measurement(value: amountOfFrames/GlobalConfig.AnimationFPS, unit: .seconds)
        animationName = AnimationNames(rawValue: json["animationName"].stringValue) ?? .resting
        isMovable = json["isMovable"].boolValue
        transition = SCNVector3(json: json["transition"])
        direction = DirectionNames(rawValue: json["directionName"].stringValue)
        compatibleMovements = json["compatibleMovements"].arrayValue.map { $0.stringValue }
    }
}
