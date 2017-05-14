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
    private(set) var currentExercise: Exercise?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var editBarNeedsUpdate: ((_ shouldScroll: Bool)-> Void)?
    var playLoadedAnimations: (()-> Void)?
    
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
    
    private init() {
        
    }
    
    func save(exercise: Exercise) {
    
        movements.removeAll()
        currentExercise = exercise
        appDelegate.saveContext()
    }
    
    func remove(exercise: Exercise) {
        
        context.delete(exercise)
        appDelegate.saveContext()
    }
    
    func saveCreatedAnimations() {
        
        let duration = movements.reduce(0) { (currentResult, movement) -> Double in
            
            currentResult + (movement.amountOfFrames / GlobalConfig.AnimationFPS) * Double(movement.amountOfRepeats)
        }
        
        currentExercise?.duration = duration
        
        for (index, movement) in movements.enumerated() {
            
            let animation = Animation(context: context)
            animation.amountOfRepeats = Int32(movement.amountOfRepeats)
            animation.exercise = currentExercise
            animation.name = movement.animationName.rawValue
            animation.position = Int32(index)
        }
        
        appDelegate.saveContext()
        
        print("Duration of animation is \(duration)")
    }
    
    func userSelected(exercise: Exercise, with animations: [Animation]) {
        
        movements.removeAll()
        currentExercise = exercise
        
        let availableMovements = Assets.data(from: "Movements")["movements"].arrayValue.map { Movement(json: $0) }
        
        for animation in animations {
            
            guard let movement = availableMovements.first(where: { $0.animationName.rawValue == animation.name }) else { return }
            
            movement.amountOfRepeats = Int(animation.amountOfRepeats)
            movements.append(movement)
            
            print("◼︎ user wants to load animation with name \(animation.name), amount of repeats \(animation.amountOfRepeats) and position \(animation.position)")
        }
        
        playLoadedAnimations?()
    }
    
    func testLoadOfAllAnimations() {
    
        do {
            let animations = try context.fetch(Animation.fetchRequest())
            
            print("We loaded \(animations.count) animations")
            
        } catch {
            print("Fetching Failed")
        }
    
    }
}
