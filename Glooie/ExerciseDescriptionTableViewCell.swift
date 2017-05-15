//
//  ExerciseDescriptionTableViewCell.swift
//  Glooie
//
//  Created by Michael Gerasimov on 4/30/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit
import CoreData

class ExerciseDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var disclosureButton: UIButton!
    
    var exercise: Exercise? = nil {
        
        didSet {
            
            guard let exercise = exercise else { return }
            
            nameLabel.text = exercise.name
            
            let type = ExerciseType.Types(rawValue: exercise.type ?? String()) ?? . none
            let exerciseType = DataModelManager.shared.allAvailableExerciseTypes.filter { $0.type == type }.first
            
            typeLabel.textColor = type.typeColor()
            typeLabel.text = type.rawValue
            
            let duration = Measurement(value: exercise.duration, unit: UnitDuration.seconds)
            
            let formater = MeasurementFormatter()
            formater.unitOptions = .naturalScale
            formater.unitStyle = .short
            durationLabel.text = String(format:"Duration: %@", formater.string(from: duration))
            
            typeImageView.image = exerciseType?.image
            
            disclosureButton.tintColor = type.typeColor()
        }
    }
}
