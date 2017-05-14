//
//  ExerciseDescriptionViewController.swift
//  Glooie
//
//  Created by Michael Gerasimov on 4/30/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class ExerciseDescriptionViewController: BasicViewController {

    @IBOutlet private weak var descriptionTextView: UITextView!
    
    var exerciseDescription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.text = exerciseDescription
    }
}
