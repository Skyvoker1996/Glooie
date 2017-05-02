//
//  ExerciseDescriptionTableViewCell.swift
//  Glooie
//
//  Created by Michael Gerasimov on 4/30/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class ExerciseDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var typeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
