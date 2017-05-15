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
    
    var editingMode: Bool = false {
        
        didSet {
            
            let createBarButtonItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openCreateExerciseVC(_:)))
            let saveBarButtomItem = UIBarButtonItem(image: #imageLiteral(resourceName: "finish flag filled"), style: .plain, target: self, action: #selector(saveExercise))
            
            navigationItem.rightBarButtonItem = editingMode ? saveBarButtomItem : createBarButtonItem
            
            editBarHeightConstraint.constant = editingMode ? ExercisePresentationConstants.EditBarHeight : 0
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity:0 , options: [.curveEaseOut], animations: {
                
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            print("🍐 triggered edit mode")
        }
    }
    
    fileprivate var preparedAvailableMovements: [Movement] {
        
        get {
            
            guard let lastMovement = brain.movementsSelectedByUser.last,
                  let compatibleMovements = brain.allAvailableMovements.first(where: { $0.animationName == lastMovement.animationName })?.compatibleMovements
            else { return [] }
           
            return brain.allAvailableMovements.filter { compatibleMovements.contains($0.name) }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        brain.playLoadedAnimations = { [weak self] in
            
            guard let strongSelf = self else { return }
            
            strongSelf.resetPosition()
            strongSelf.play(movements: strongSelf.brain.movementsSelectedByUser)
        }
        
        setupUI()
        setupScene()
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
        
        let createBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openCreateExerciseVC(_:)))
        navigationItem.rightBarButtonItem = createBarButtonItem
    }
    
    func setupScene() {
    
        scnView.scene = scnScene
        scnView.allowsCameraControl = true
        scnView.showsStatistics = true
        scnView.preferredFramesPerSecond = Int(GlobalConfig.AnimationFPS)
    }
    
    func setupNodes() {
    
        goalkeeperRig = Assets.node(in: scnScene, named: .rig)
    }
    
    // MARK: - Others
    
    func openCreateExerciseVC(_ sender: Any) {
        
        performSegue(withIdentifier: Segues.newExercise.rawValue, sender: sender)
    }
    
    func saveExercise() {
        
        editingMode = false
        DataModelManager.shared.saveCreatedAnimations()
    }
    
    func resetPosition() {
        
        goalkeeperRig.position = SCNVector3(0, 0, 0)
        goalkeeperRig.removeAllActions()
        goalkeeperRig.removeAllAnimations()
        playAnimationButton.isSelected = true
    }
    
    func play(movements: [Movement]) {
        
        animationHelper.playMovements(movements, attachedTo: goalkeeperRig) { [weak self] in
            
            guard let strongSelf = self else { return }
            
            strongSelf.playAnimationButton.isHidden = true
            strongSelf.repeatAnimationButton.isHidden = false
            
            print("Finished playing animations")
        }
    }
    
    // MARK: - Actions
    
    @IBAction func repeatMovements(_ sender: UIButton) {
        
        playAnimationButton.isHidden = false
        playAnimationButton.isSelected = true
        repeatAnimationButton.isHidden = true
        resetPosition()
        play(movements: brain.movementsSelectedByUser)
    }
    
    @IBAction func playPauseMovements(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        scnScene.isPaused = !sender.isSelected
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
        
        rootController.compatibleMovements = preparedAvailableMovements
        
        present(vc, animated: true, completion: nil)
    }
}

extension ExercisePresentationViewController: NewExerciseDelegate {
    
    func willCreateNewExercise(_ isCreated: Bool) {
        editingMode = isCreated
    }
}
