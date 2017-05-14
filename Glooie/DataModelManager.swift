//
//  DataModelBrain.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/13/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit
import CoreData

class DataModelManager {
    
    static let shared = DataModelManager()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var movements: [Movement] = [] {
        
        didSet {
            
            editBarNeedsUpdate?(oldValue.count < movementsSelectedByUser.count)
            
            print("🍐 Added new movement, oldValue \(oldValue.count), newValue\(movementsSelectedByUser.count)")
        }
    }
    
    var movementsSelectedByUser: [Movement] {
        set {
            
            guard let newLastElement = newValue.last,
                let oldLastElement = movementsSelectedByUser.last,
                newLastElement == oldLastElement,
                newValue.count > movements.count else {
            
                movements = newValue
                return
            }
            
            oldLastElement.amountOfRepeats += 1
            editBarNeedsUpdate?(false)
        }
        get {
            
            return movements
        }
    }
    
    var editBarNeedsUpdate: ((_ shouldScroll: Bool)-> Void)?
    
    private init() {
        
    }
    
    func saveNewExercise() {
    
        appDelegate.saveContext()
    }
    
    func remove(exercise: Exercise) {
        
        context.delete(exercise)
        saveNewExercise()
    }
}
