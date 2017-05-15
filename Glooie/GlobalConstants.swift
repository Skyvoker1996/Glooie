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

enum Headers: String {
    
    case basicCollectionViewHeader = "basicCollectionViewHeader"
}

enum Cells: String {
    
    case editBarCollectionCell = "editBarCell"
    case exerciseCell = "exerciseCell"
    case movementTypeCell = "movementTypeCell"
    case directionCollectionCell = "directionCollectionCell"
    case movementSelectionCollectionCell = "movementSelectionCell"
    case contentCollectionCell = "contentCell"
    case movementCell = "movementCell"
}

enum ViewNames: String {
    
    case newExercisePickerView = "NewExercisePickerView"
}

enum NodeNames: String {
    
    case rig
    case camera
    case follow_camera
}

enum SceneNames: String {
    
    case main = "Main.scn"//"Goalkeeper animated experements.dae"

}

enum DirectionNames: String {
    
    case leftDown
    case leftTop
    case rightDown
    case rightTop
    case up
    case down
    case forward
    case backward
    case middle
    case left
    case right
    case none
}

enum AnimationNames: String {
    
    case resting = "resting.dae"
    case readiness = "readiness.dae"
    case jumpForward = "jump.dae"
    case catchBallNearGroundOnKneesLeft = "catch ball near the ground (standing on knees)_left.dae"
    case catchBallNearGroundOnKneesRight = "catch ball near the ground (standing on knees)_right.dae"
    case catchBallStandingStraight = "catch ball in straight position.dae"
    case catchBallInAirKneesRight = "catch ball in air (standing on knees)_right.dae"
    case catchBallInAirKneesLeft = "catch ball in air (standing on knees)_left.dae"
    case catchBallStandingStraightMiddle = "catch ball on middle height.dae"
    case catchBallStraightStraightDown = "catch ball straight near the ground_right_side.dae"
    case catchBallInAirLeft = "catch high ball left_side.dae"
    case catchBallInAirRight = "catch high ball right_side.dae"
    case catchBallNearGroundLeft = "catch low ball left_side.dae"
    case catchBallNearGroundRight = "catch low ball right_side.dae"
    case getUpFromKnees = "get up from knees.dae"
    case leanHead = "lean head from side to side.dae"
    case sidestepLeft = "sidestep_left.dae"
    case sidestepRight = "sidestep_right.dae"
    case standOnKnees = "stand on knees.dae"
    case somersault = "somersault.dae"
    case none
    
    func animation(amountOfRepeats: Int) -> CAAnimation {
        
        switch self {
        case .none:
            return CAAnimation()
        default:
            return Assets.animation(named: self, repeats: amountOfRepeats)
        }
    }
}

enum Segues: String {
    
    case exerciseDescription = "showExerciseDescription"
    case newExercise = "showNewExerciseFormSheet"
    case movements = "showMovement"
}

struct ExercisePresentationConstants {
    
    static let EditBarHeight: CGFloat = 150
}
