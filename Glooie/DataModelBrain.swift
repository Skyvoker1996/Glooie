//
//  DataModelBrain.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/13/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import Foundation

class DataModelBrain {
    
    static let shared = DataModelBrain()
    
    var movementsSelectedByUser: [Movement] = [] {
        didSet {
            
            editBarNeedsUpdate?(oldValue.count < movementsSelectedByUser.count)
            print("🍐 Added new movement, oldValue \(oldValue.count), newValue\(movementsSelectedByUser.count)")
        }
    }
    
    var editBarNeedsUpdate: ((_ shouldScroll: Bool)-> Void)?
    
    private init() {
        
    }
}
