//
//  GlobalConstants.swift
//  Glooie
//
//  Created by Michael Gerasimov on 4/23/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit

struct GlobalConfig {
    
    static let AnimationFPS: Double = 24
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

enum ViewNames: String {
    
    case newExercisePickerView = "NewExercisePickerView"
}

enum NodeNames: String {
    
    case rig = "rig"
    case root = "root"
}

enum SceneNames: String {
    
    case main = "Goalkeeper animated experements copy.scn"//"Goalkeeper animated experements.dae"

}

enum DirectionNames: String {
    
    case leftDown
    case leftTop
    case rightDown
    case rightTop
    case up
    case down
}

enum AnimationNames: String {
    
    case resting = "resting.dae"
    case readiness = "readiness.dae"
    case jump_forward = "jump forward.dae"
    case jump = "jump.dae"
    case catchBallNearGround = "catch ball near the ground (standing on knees)_left.dae"
}

enum Segues: String {
    
    case exerciseDescription = "showExerciseDescription"
    case newExercise = "showNewExerciseFormSheet"
}

struct ExercisePresentationConstants {
    
    static let EditBarHeight: CGFloat = 150
}
