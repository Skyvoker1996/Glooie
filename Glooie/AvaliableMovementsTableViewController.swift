//
//  AvaliableMovementsTableViewController.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/2/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class AvaliableMovementsTableViewController: UITableViewController {
    
    var movements: [Movement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}
