//
//  CAAnimationExtension.swift
//  Glooie
//
//  Created by Michael Gerasimov on 4/24/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import SceneKit

extension CAAnimation {
    class func animation(withSceneName name: String) -> CAAnimation {

        guard let scene = SCNScene(named: name) else {
            fatalError("Failed to find scene with name \(name).")
        }
        
        var animation: CAAnimation?
        scene.rootNode.enumerateChildNodes { (child, stop) in
            guard let firstKey = child.animationKeys.first else { return }
            animation = child.animation(forKey: firstKey)
            stop.initialize(to: true)
        }
        
        guard let foundAnimation = animation else {
            fatalError("Failed to find animation named \(name).")
        }
        
        foundAnimation.fadeInDuration = 0.6
        foundAnimation.fadeOutDuration = 0.6
        foundAnimation.repeatCount = 3
        
        return foundAnimation
    }
}
