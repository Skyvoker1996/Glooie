//
//  EditBarCollectionViewCell.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/1/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class EditBarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var amountOfRepeatsLabel: UILabel!
    @IBOutlet weak var anumationTitleLabel: UILabel!
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    @IBOutlet weak var stepper: UIStepper!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupGestureRecognizer()
    }
    
    func updateUI() {
        
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
    
        updateUI()
    }
    
    @IBAction func removeAnimationBlock(_ sender: UIButton) {
    
        
    }
    
    @IBAction func dismissRemoveButton(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.visualEffect.alpha = 0
        }) {_ in
            
            self.visualEffect.isHidden = false
        }
    }
}
