//
//  NewExercisePickerView.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/5/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class NewExercisePickerView: UIView {

    @IBOutlet weak var exerciseTypeImageView: UIImageView!
    @IBOutlet weak var exerciseTypeTitle: UILabel!
    
    var exercise: ExerciseType = ExerciseType(json: []) {
        didSet {
            exerciseTypeTitle.text = exercise.type
            exerciseTypeImageView.image = exercise.image
        }
    }
}
