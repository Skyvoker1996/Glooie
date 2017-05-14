//
//  ExerciseType.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/11/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import SwiftyJSON
import UIKit

class ExerciseType {
    
    enum Types: String {
        
        case agility = "Agility"
        case concentration = "Concentration"
        case jumpingAbility = "Jumping ability"
        case reaction = "Reaction"
        case speed = "Speed"
        case stamina = "Stamina"
        case none
        
        func typeColor() -> UIColor {
            switch self {
            case .agility:
                return UIColor(r: 39, g: 174, b: 96)
            case .concentration:
                return UIColor(r: 211, g: 84, b: 0)
            case .jumpingAbility:
                return UIColor(r: 41, g: 128, b: 185)
            case .reaction:
                return UIColor(r: 155, g: 89, b: 182)
            case .speed:
                return UIColor(r: 44, g: 62, b: 80)
            case .stamina:
                return UIColor(r: 254, g: 200, b: 76)
            case .none:
                return .black
            }
        }
    }
    
    let type: Types
    let image: UIImage
    
    init(json: JSON) {
        
        type = Types(rawValue: json["type"].stringValue) ?? .none
        image = UIImage(named: json["image"].stringValue) ?? UIImage()
    }
}
