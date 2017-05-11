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
    
    let type: String
    let image: UIImage
    
    init(json: JSON) {
        
        type = json["type"].stringValue
        image = UIImage(named: json["image"].stringValue) ?? UIImage()
    }
}
