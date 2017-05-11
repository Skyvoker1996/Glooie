//
//  AvliableAnimationsTableViewController.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/2/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class AvailableAnimationsViewController: BasicViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension AvailableAnimationsViewController: UITableViewDataSource {

    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.movementTypeCell.rawValue, for: indexPath)
        
        cell.textLabel?.text = "Basic"
        return cell
    }
}
