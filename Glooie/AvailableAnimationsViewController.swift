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
    
    let brain = DataModelManager.shared
    
    var compatibleMovements: [Movement] = [] {
        didSet {
            
            movementTypes = brain.allAvailableMovementTypes.filter { type in
                
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
        
        if brain.movementsSelectedByUser.count == 0,
            let compatibleMovements = brain.allAvailableMovements.first(where: { $0.animationName == .resting })?.compatibleMovements {
                
            self.compatibleMovements = brain.allAvailableMovements.filter { compatibleMovements.contains($0.name) }
        }
        
        if compatibleMovements.count == 0 {

            showEmptyView()
        }
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier,
        identifier == Segues.movements.rawValue,
            let vc = segue.destination as? AvaliableMovementsTableViewController, let selectedType = sender as? MovementType.Types else { return }
        
        vc.movements = compatibleMovements.filter { $0.movementType == selectedType}
    }
    
    func showEmptyView() {
        
        let emptyView = UIView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.backgroundColor = .white
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .darkGray
        label.text = "There are no compatible movements with current state"
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightThin)
        
        emptyView.addSubview(label)
        view.addSubview(emptyView)
        
        NSLayoutConstraint.activate([
            
            label.widthAnchor.constraint(equalTo: emptyView.widthAnchor, multiplier: 0.6),
            label.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
            
            view.topAnchor.constraint(equalTo: emptyView.topAnchor),
            view.bottomAnchor.constraint(equalTo: emptyView.bottomAnchor),
            view.leftAnchor.constraint(equalTo: emptyView.leftAnchor),
            view.rightAnchor.constraint(equalTo: emptyView.rightAnchor)
            ])
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
            
            cell.delegate = self
            cell.movementType = movementTypes[indexPath.row]
            
            return cell
        }
        
        return UITableViewCell()
    }
}

extension AvailableAnimationsViewController: MovementTypeTableViewCellDelegate {
    
    func didSelect(direction: DirectionNames) {
        
        let movementSelectedByUser = compatibleMovements.filter { $0.movementType == .catchLocation && $0.direction == direction }.first
        
        guard movementSelectedByUser != nil else { return }
        
        brain.movementsSelectedByUser.append(movementSelectedByUser!)
        
        dismiss(animated: true, completion: nil)
    }
}
