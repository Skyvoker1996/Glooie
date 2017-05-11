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

class ExercisePresentationViewController: BasicViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var scnView: SCNView!
    @IBOutlet weak var editBarHeightConstraint: NSLayoutConstraint!
    
    let animationHelper = AnimationHelper()
    
    let readinessAnimation = Assets.animation(named: .readiness)
    let restingAnimation = Assets.animation(named: .resting)
    let jumpAnimation = Assets.animation(named: .jump)
    let catchBallGroundAnimation = Assets.animation(named: .catchBallNearGround)
    
    var goalkeeperRig: SCNNode!
    
    let scnScene: SCNScene = Assets.scene(named: .main)
    let testScene = SCNScene(named: "SceneKit Scene.scn")
    
    var editingMode: Bool = false {
        
        didSet {
            
            let createBarButtonItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createExercise(_:)))
            let saveBarButtomItem = UIBarButtonItem(image: #imageLiteral(resourceName: "finish flag filled"), style: .plain, target: self, action: #selector(saveExercise))
            
            navigationItem.rightBarButtonItem = editingMode ? saveBarButtomItem : createBarButtonItem
            
            editBarHeightConstraint.constant = editingMode ? ExercisePresentationConstants.EditBarHeight : 0
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity:0 , options: [.curveEaseOut], animations: {
                
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            print("🍐 triggered edit mode")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupScene()
        //setupGestureRecognizer()
        // Comment to enter demo mode
        //setupNodes()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier ?? String() {
            
        case Segues.newExercise.rawValue:
            if let vc = (segue.destination as? UINavigationController)?.visibleViewController as? NewExerciseViewController {
                
                vc.delegate = self
            }
        default:
            break
        }
    }
    
    // MARK: - Setup functions
    
    func setupUI() {
        
        let createBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createExercise(_:)))
        navigationItem.rightBarButtonItem = createBarButtonItem
    }
    
//    func setupGestureRecognizer() {
//        
//        let gr = UITapGestureRecognizer(target: self, action: #selector(addAnimation(recognizer:)))
//        
//        gr.delegate = self
//        gr.numberOfTapsRequired = 2
//        scnView.addGestureRecognizer(gr)
//    }
    
    func setupScene() {
    
        // Change to enter demo mode
      //  scnView.scene = scnScene
        scnView.scene = testScene
        //scnView.delegate = self
        scnView.allowsCameraControl = true
        scnView.showsStatistics = true
        scnView.preferredFramesPerSecond = 24
    }
    
    func setupNodes() {
    
        goalkeeperRig = Assets.node(in: scnScene, named: .rig)
    }
    
    // MARK: - Others
    
    func createExercise(_ sender: Any) {
        
        performSegue(withIdentifier: Segues.newExercise.rawValue, sender: sender)
    }
    
    func saveExercise() {
        
        editingMode = false
    }
    
    func addAnimations() {
        
        
        let animations = Array<CAAnimation>(repeating: jumpAnimation, count: 2)
        
        var animationsSequence: [CAAnimation] = []
        
        animationsSequence.append(contentsOf: animations)
        
        print("🍐 Start positon \(goalkeeperRig.presentation.position)")
        
        animationHelper.playAnimations(animations, attachedTo: goalkeeperRig) {
            
            print("🍐 Finish positon \(self.goalkeeperRig.presentation.position)")
            print("Finished playing animations")
        }
        
//        let waitAnimation = SCNAction.wait(duration: 25/24)
//        let moveAnimation = SCNAction.move(by: SCNVector3(0, -2.485, 0), duration: 16/24)
//        let moveAnimation = SCNAction.move(by: SCNVector3(0, -2.485, 0), duration: 10)
//        
//        let group = SCNAction.group([moveAnimation])
//        mountNode.runAction(group)
        
        
        print("We have \(animationsSequence.count) more to play")
    }
    
    // MARK: - Actions
    
    @IBAction func animationProcessHandling(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        switch sender.isSelected {
        case true:
            addAnimations()
        case false:
            scnScene.isPaused = true
        }
    }
    
    @IBAction func showAvailableAnimations(_ sender: UILongPressGestureRecognizer) {
        
        guard editingMode else { return }
        
        let storyboard = UIStoryboard(name: GlobalConfig.StoryboardName, bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: ViewControllers.movementSelectionNavigationController.rawValue) as? UINavigationController
        else { return }
        vc.modalPresentationStyle = .popover
        
        guard let popover = vc.popoverPresentationController else { return }
        
        let origin = sender.location(in: scnView)
        let rect = CGRect(origin: origin, size: CGSize(width: 5, height: 5))
        
        popover.sourceView = scnView
        popover.sourceRect = rect
        present(vc, animated: true, completion:nil)
    }
}

extension ExercisePresentationViewController: NewExerciseDelegate {
    
    func willCreateNewExercise(_ isCreated: Bool) {
        editingMode = isCreated
    }
}

//extension ExercisePresentationViewController: SCNSceneRendererDelegate {
//    
//    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
//        
//        
//    }
//    
//    func renderer(_ renderer: SCNSceneRenderer, didApplyAnimationsAtTime time: TimeInterval) {
//        
//        renderer.scene
//    }
//}
