//
//  EditBarCollectionViewCell.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/1/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit

protocol EditBarCollectionViewCellDelegate: class {
    
    func itemNeedsToBeDeleted(_ sender: UIButton)
    func updateAmountOfRepeats(to value: Int, with sender: UIView)
}

class EditBarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var amountOfRepeatsLabel: UILabel!
    @IBOutlet weak var animationTitleLabel: UILabel!
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var directionImageView: UIImageView!
    
    weak var delegate: EditBarCollectionViewCellDelegate?
    
    var movement: Movement = Movement(json: []) {
        didSet {
            
            animationTitleLabel.text = movement.name
            directionImageView.image = UIImage(named: movement.direction?.rawValue ?? String())
            amountOfRepeatsLabel.text = String(format: "%d", movement.amountOfRepeats)
            directionImageView.isHidden = movement.direction == nil
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupGestureRecognizer()
    }
    
    private func updateUI() {
        
        amountOfRepeatsLabel.text = String(format: "%.0f", stepper.value)
    }
    
    func setupGestureRecognizer() {
    
        let gr = UITapGestureRecognizer(target: self, action: #selector(toggleDeletionView(recognizer:)))
        gr.numberOfTapsRequired = 2
        addGestureRecognizer(gr)
    }
    
    func toggleDeletionView(recognizer: UIGestureRecognizer) {

        visualEffect.isHidden = false
        UIView.animate(withDuration: 0.3, animations: { 
            self.visualEffect.alpha = 1
        })
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
    
        delegate?.updateAmountOfRepeats(to: Int(sender.value), with: sender)
        updateUI()
    }
    
    @IBAction func removeAnimationBlock(_ sender: UIButton) {
    
        dismissRemoveButton(sender)
        delegate?.itemNeedsToBeDeleted(sender)
    }
    
    @IBAction func dismissRemoveButton(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.visualEffect.alpha = 0
        }) {_ in
            
            self.visualEffect.isHidden = false
        }
    }
}
