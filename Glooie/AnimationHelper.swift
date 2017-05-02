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
    
    func playAnimations(_ animations: [CAAnimation], attachedTo node: SCNNode, completion: (()->Void)?) {
        
        switch animations.count {
        case 0:
            print("You did not provide any animations")
            break
        default:
            
            var animationsToUse = animations
            let animation = animationsToUse.removeFirst()
            
            SCNTransaction.begin()
            SCNTransaction.completionBlock = {
                
                switch animationsToUse.count > 0 {
                case true:
                    self.playAnimations(animationsToUse, attachedTo: node, completion: completion)
                case false:
                    node.removeAllAnimations()
                    completion?()
                }
            }
            
            node.addAnimation(animation, forKey: nil)
            
            SCNTransaction.commit()
        }
    }
}
