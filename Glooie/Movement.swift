//
//  Movement.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/11/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import SceneKit
import SwiftyJSON

class Movement: Equatable {
    
    let name: String
    let duration: Measurement<UnitDuration>
    let movementType: MovementType.Types
    let animationName: AnimationNames
    let isMovable: Bool
    let transition: SCNVector3?
    let direction: DirectionNames?
    let amountOfFrames: Double
    var amountOfRepeats: Int = 1
    let compatibleMovements: [String]
    
    init(json: JSON) {
        
        name = json["name"].stringValue
        amountOfFrames = json["amountOfFrames"].doubleValue
        movementType = MovementType.Types(rawValue: json["movementType"].stringValue) ?? .none
        duration = Measurement(value: amountOfFrames/GlobalConfig.AnimationFPS, unit: .seconds)
        animationName = AnimationNames(rawValue: json["animationName"].stringValue) ?? .none
        isMovable = json["isMovable"].boolValue
        transition = SCNVector3(json: json["transition"])
        direction = DirectionNames(rawValue: json["directionName"].stringValue)
        compatibleMovements = json["compatibleMovements"].arrayValue.map { $0.stringValue }
    }
    
    static func ==(lhs: Movement, rhs: Movement) -> Bool {
        return lhs.name == rhs.name &&
            rhs.direction == lhs.direction
    }
}
