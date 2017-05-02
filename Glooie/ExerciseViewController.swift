//
//  ExerciseViewController.swift
//  Glooie
//
//  Created by Michael Gerasimov on 3/9/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class ExerciseViewController: UITableViewController {
        
    var dataSource = ["", "", "", "", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier ?? String() {
            
        case Segues.exerciseDescription.rawValue:
            if let _ = segue.destination as? ExerciseDescriptionViewController {
                
                let backItem = UIBarButtonItem()
                backItem.title = "Back"
                backItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white as Any], for: .normal)
                navigationItem.backBarButtonItem = backItem
                
                //vc.exerciseDescription = ""
            }
        default:
            break
        }
    }
}

extension ExerciseViewController {
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        
        case .delete:
            
            dataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            break
        }
    }
}

extension ExerciseViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cells.exerciseCell.rawValue, for: indexPath) as? ExerciseDescriptionTableViewCell {
        
            return cell
        }
        
        return UITableViewCell()
    }

}

