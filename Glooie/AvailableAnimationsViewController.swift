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
    
    var compatibleMovements: [Movement] = [] {
        didSet {
        
            let allAvailableMovementTypes = Assets.data(from: "MovementTypes")["types"].arrayValue.map { MovementType(json: $0) }
            
            movementTypes = allAvailableMovementTypes.filter { type in
                
                compatibleMovements.contains { $0.movementType == type.type }
            }
        }
    }
    
    fileprivate var movementTypes = [MovementType]() {
        didSet {
            
            for movementType in movementTypes where movementType.type == .catchLocation {
                
                movementType.directions = compatibleMovements.flatMap { $0.movementType == .catchLocation ? $0.direction : nil }
            }
            
            tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier,
        identifier == Segues.movements.rawValue,
            let vc = segue.destination as? AvaliableMovementsTableViewController, let selectedType = sender as? MovementType.Types else { return }
        
        vc.movements = compatibleMovements.filter { $0.movementType == selectedType}
    }
}

extension AvailableAnimationsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return movementTypes[indexPath.row].type != .catchLocation
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        performSegue(withIdentifier: Segues.movements.rawValue, sender: movementTypes[indexPath
            .row].type)
    }
}

extension AvailableAnimationsViewController: UITableViewDataSource {

    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movementTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cells.movementTypeCell.rawValue, for: indexPath) as? MovementTypeTableViewCell {
            
            cell.movementType = movementTypes[indexPath.row]
            
            return cell
        }
        
        return UITableViewCell()
    }
}
