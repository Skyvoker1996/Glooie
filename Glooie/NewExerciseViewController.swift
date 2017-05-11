//
//  NewExerciseViewController.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/1/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol NewExerciseDelegate: class {
    
    func willCreateNewExercise(_ isCreated: Bool)
}

class NewExerciseViewController: BasicViewController {

    @IBOutlet weak var exerciseTitleLabel: UITextField!
    @IBOutlet weak var exerciseTypePickerView: UIPickerView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    weak var delegate: NewExerciseDelegate?
    
    let exerciseTypes: [ExerciseType] = Assets.data(from: "ExerciseTypes")["exerciseTypes"].arrayValue.map { ExerciseType(json: $0)}
    
    let textViewPlaceholder = "Enter exercise description"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        validate(textView: descriptionTextView)
    }
    
    @IBAction func dismissViewController(_ sender: UIBarButtonItem) {
        
        navigationController?.dismiss(animated: true) {
            
            if sender.tag == 1 {
                
                self.delegate?.willCreateNewExercise(true)
            }
        }
    }
    
    func validate(textView: UITextView) {
        
        switch textView.text {
        case String():
            
            textView.text = textViewPlaceholder
            textView.textColor = .lightGray
        case textViewPlaceholder:
            
            textView.text = String()
            textView.textColor = .black
        default:
            break
        }
    }
}

extension NewExerciseViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        guard let view = view else {
            
            let reusableView = Bundle.main.loadNibNamed(ViewNames.newExercisePickerView.rawValue, owner: self, options: nil)?.first as? NewExercisePickerView
            
            reusableView?.exercise = exerciseTypes[row]
            return reusableView ?? UIView()
        }
        
        return view
    }
}

extension NewExerciseViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return exerciseTypes.count
    }
}

extension NewExerciseViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        validate(textView: textView)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        validate(textView: textView)
    }
}
