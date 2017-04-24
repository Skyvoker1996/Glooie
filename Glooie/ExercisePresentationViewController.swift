//
//  ExercisePresentationViewController.swift
//  Glooie
//
//  Created by Michael Gerasimov on 4/24/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class ExercisePresentationViewController: UIViewController {

    @IBOutlet weak var scnView: SCNView!
    
    var scnScene: SCNScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScene()
    }

    func setupScene() {
        
        //scnView.allowsCameraControl = true
        //scnView.showsStatistics = true
        
        scnScene = SCNScene(named: "Art.scnassets/presentation.scn")
        scnView.scene = scnScene
    }
}
