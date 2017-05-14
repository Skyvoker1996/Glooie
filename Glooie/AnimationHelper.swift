//
//  AnimaitonHelper.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/1/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import SceneKit
import QuartzCore

class AnimationHelper {
    
    func playMovements(_ movements: [Movement], attachedTo node: SCNNode, completion: (()->Void)?) {
        
        switch movements.count {
        case 0:
            print("You did not provide any animations")
            break
        default:
            
            var movementToUse = movements
            let movement = movementToUse.removeFirst()
            
            SCNTransaction.begin()
            SCNTransaction.completionBlock = {
                
                switch movementToUse.count > 0 {
                case true:
                    self.playMovements(movementToUse, attachedTo: node, completion: completion)
                case false:
                    completion?()
                }
            }
            
            switch movement.isMovable {
            case true:
                
                if let transition = movement.transition {
                    
                    let actions = Array<SCNAction>(repeating: SCNAction.move(by: transition, duration: (movement.amountOfFrames-5)/30), count: movement.amountOfRepeats)
                    let actionSequence = SCNAction.sequence(actions)
                    actionSequence.timingMode = .easeInEaseOut
                    
                    node.runAction(actionSequence)
                }
                
                fallthrough
            case false:
                
                node.addAnimation(movement.animationName.animation(amountOfRepeats: movement.amountOfRepeats) , forKey: nil)
            }
            
            SCNTransaction.commit()
        }
    }
}
