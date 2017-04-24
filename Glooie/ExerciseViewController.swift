//
//  ExerciseViewController.swift
//  Glooie
//
//  Created by Michael Gerasimov on 3/9/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

extension ExerciseViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.exerciseCell.rawValue, for: indexPath)
        
        return cell
    }

}

