//
//  SCNVector3Extension.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/11/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import SceneKit
import SwiftyJSON

extension SCNVector3 {
    
    init(json: JSON) {
        
        let x = json["x"].doubleValue
        let y = json["y"].doubleValue
        let z = json["z"].doubleValue
        
        self = SCNVector3(x, y, z)
        
    }
}
