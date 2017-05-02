//
//  GlobalConstants.swift
//  Glooie
//
//  Created by Michael Gerasimov on 4/23/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit

struct GlobalConfig {
    
    static let StoryboardName = "Main"
    static let NavBarAttributes = [NSForegroundColorAttributeName: UIColor.white as Any, NSFontAttributeName: UIFont.systemFont(ofSize: 18, weight: UIFontWeightRegular) as Any]
}

enum ViewControllers: String {
    case avaliableAnimations = "avaliableAnimationsViewController"
    case movementSelectionNavigationController = "movementSelectionViewController"
}

enum Cells: String {
    
    case editBarCollectionCell = "editBarCell"
    case exerciseCell = "exerciseCell"
    case movementTypeCell = "movementTypeCell"
}

enum NodeNames: String {
    
    case rig = "rig"
}

enum SceneNames: String {
    
    case main = "Goalkeeper animated experements.dae"

}

enum AnimationNames: String {
    
    case resting = "resting.dae"
    case readiness = "readiness.dae"
}

enum Segues: String {
    
    case exerciseDescription = "showExerciseDescription"
    case newExercise = "showNewExerciseFormSheet"
}

struct ExercisePresentationConstants {
    
    static let EditBarHeight: CGFloat = 150
}
