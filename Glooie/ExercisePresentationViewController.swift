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
    @IBOutlet weak var playAnimationButton: UIButton!
    @IBOutlet weak var repeatAnimationButton: UIButton!
    
    let animationHelper = AnimationHelper()
    let brain = DataModelManager.shared
    
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
        
        brain.playLoadedAnimations = { [unowned self] in
            
            self.goalkeeperRig.removeAllActions()
            self.goalkeeperRig.removeAllAnimations()
            self.animationProcessHandling(self.playAnimationButton)
        }
        
        setupUI()
        setupScene()
        // Comment to enter demo mode
        setupNodes()
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
    
    func setupScene() {
    
        // Change to enter demo mode
        scnView.scene = scnScene
        //scnView.scene = testScene
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
        DataModelManager.shared.saveCreatedAnimations()
    }
    
    func play(movements: [Movement]) {
        
        animationHelper.playMovements(movements, attachedTo: goalkeeperRig) {
            
            print("🍐 Finish positon \(self.goalkeeperRig.presentation.position)")
            print("Finished playing animations")
        }
        
        //print("We have \(animationsSequence.count) more to play")
    }
    
    // MARK: - Actions
    
    @IBAction func animationProcessHandling(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        switch sender.isSelected {
        case true:
            play(movements: brain.movementsSelectedByUser)
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
        
        guard let rootController = vc.visibleViewController as? AvailableAnimationsViewController else { return }
        
        if let lastMovement = brain.movementsSelectedByUser.last {
            
            let movements = Assets.data(from: "Movements")["movements"].arrayValue.map { Movement(json: $0) }
            
            if let compatibleMovements = movements.first(where: { $0.animationName == lastMovement.animationName })?.compatibleMovements {
                
                print("😎 \(compatibleMovements)")
                rootController.compatibleMovements = movements.filter { compatibleMovements.contains($0.name) }
            }
        }
        
        present(vc, animated: true, completion:nil)
    }
}

extension ExercisePresentationViewController: NewExerciseDelegate {
    
    func willCreateNewExercise(_ isCreated: Bool) {
        editingMode = isCreated
    }
}
