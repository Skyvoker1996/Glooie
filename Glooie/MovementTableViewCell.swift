//
//  MovementTableViewCell.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/12/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class MovementTableViewCell: UITableViewCell {

    @IBOutlet weak var movementTitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    var movement: Movement = Movement(json: []) {
        didSet {
            
            movementTitleLabel.text = movement.name
            collectionView.reloadData()
        }
    }
}

extension MovementTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: indexPath.row == 0 ? 40 : 30)
    }
}

extension MovementTableViewCell: UICollectionViewDelegate { }

extension MovementTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.movementSelectionCollectionCell.rawValue, for: indexPath) as? MovementSelectionCollectionViewCell {
            
            cell.dataType = indexPath.row == 0 ? .directions : .compatibleMovements
            cell.compatibleMovements = movement.compatibleMovements
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}
