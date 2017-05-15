//
//  AvaliableMovementsTableViewController.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/2/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class AvaliableMovementsTableViewController: UITableViewController {
    
    private let brain = DataModelManager.shared
    
    var movements: [Movement] = []
    
    private var customDataStructure: [[Movement]] = [[]] {
        didSet {
            
            tableView?.reloadData()
        }
    }
    
    func updateBrainData(with movement: Movement) {
        
        
        brain.movementsSelectedByUser.append(movement)
        brain.playLoaded?([movement], false)
        
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customDataStructure = movements.enumerated().flatMap { index, movement -> [Movement]? in
            
            let wontContinue = movements.prefix(upTo: index).contains { $0.name == movement.name }
            
            return wontContinue ? nil : movements.flatMap { $0.name == movement.name ? $0 : nil }
        }
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return customDataStructure.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cells.movementCell.rawValue, for: indexPath) as? MovementTableViewCell {
        
            
            cell.delegate = self
            cell.movements = customDataStructure[indexPath.row]
            cell.dataTypes = cell.movements.count > 1 ? [.directions, .compatibleMovements] : [.compatibleMovements]
            
            switch cell.dataTypes.count {
            case 1:
                
                cell.collectionViewHeight.constant = 70
            case 2:
                
                cell.collectionViewHeight.constant = 140
            default:
                break
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return customDataStructure[indexPath.row].count <= 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let movement = customDataStructure[indexPath.row].first else { return }
        
        updateBrainData(with: movement)
    }
}

extension AvaliableMovementsTableViewController: MovementTableViewCellDelegate {
    
    func userSelected(movement: Movement) {
        
        updateBrainData(with: movement)
    }
}
