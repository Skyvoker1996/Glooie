//
//  AssetManager.swift
//  Glooie
//
//  Created by Michael Gerasimov on 4/28/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import SceneKit
import SwiftyJSON

struct Assets {
    
    private static let deaLoadOptions = [SCNSceneSource.LoadingOption(rawValue: SCNSceneSourceAssetUpAxisKey): true, .preserveOriginalTopology: true]
    
    private static let basePath = "art.scnassets/"
    private static let scenes = basePath + "3D models and scenes/"
    private static let animations = basePath + "Animations/"
    
    
    static func animation(named name: AnimationNames) -> CAAnimation {
        return CAAnimation.animation(withSceneName: animations + name.rawValue)
    }
    
    static func scene(named name: SceneNames, fromDeaFile: Bool = true) -> SCNScene {
        guard let scene = SCNScene(named: name.rawValue, inDirectory: scenes, options: fromDeaFile ? deaLoadOptions : [:]) else {
            fatalError("Failed to load scene \(name).")
        }
        return scene
    }
    
    static func node(in scene: SCNScene, named name: NodeNames) -> SCNNode {
        guard let node = scene.rootNode.childNode(withName: name.rawValue, recursively: true) else {
            fatalError("Failed to load node \(name).")
        }
        return node
    }
    
    static func data(from plistFile: String) -> JSON {
    
        guard let path = Bundle.main.path(forResource: plistFile, ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) else {
            return []
        }
        
        return JSON(dictionary: dict)
    }
}
