//
//  NewExerciseViewController.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/1/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit

protocol NewExerciseDelegate: class {
    
    func willCreateNewExercise(_ isCreated: Bool)
}

class NewExerciseViewController: BasicViewController {

    weak var delegate: NewExerciseDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissViewController(_ sender: UIBarButtonItem) {
        
        navigationController?.dismiss(animated: true) {
            
            if sender.tag == 1 {
                
                self.delegate?.willCreateNewExercise(true)
            }
        }
    }
}
