//
//  MovementSelectionCollectionViewCell.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/12/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

protocol MovementSelectionCollectionViewCellDelegate: class {
    
    func didSelect(direction: DirectionNames)
}

class MovementSelectionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: MovementSelectionCollectionViewCellDelegate?
    
    var dataType: MovementTableViewCell.DataType = .none {
        
        didSet {
            
            let layout = UPCarouselFlowLayout()
            
            switch dataType {
            case .compatibleMovements:
                layout.itemSize = CGSize(width: 100, height: 40)
            case .directions:
                layout.itemSize = CGSize(width: 40, height: 40)
            case .none:
                layout.itemSize = CGSize.zero
            }
            
            layout.scrollDirection = .horizontal
            layout.sideItemScale = 0.6
            layout.sideItemAlpha = 0.6
            collectionView.collectionViewLayout = layout
        }
    }
    
    var data: (compatibleMovements: [String], directions: [DirectionNames]) = ([], []) {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension MovementSelectionCollectionViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return dataType == .directions
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard dataType == .directions else { return }
        
        delegate?.didSelect(direction: data.directions[indexPath.row])
        print("🌳")
    }
}

extension MovementSelectionCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataType == .directions ? data.directions.count : data.compatibleMovements.count == 0 ? 1 : data.compatibleMovements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.contentCollectionCell.rawValue, for: indexPath) as? ContentCollectionViewCell {
        
            switch dataType {
            case .directions:
                
                cell.directionImageView.isHidden = false
                cell.compatibleMovementLabel.isHidden = true
                cell.directionImageView.image = UIImage(named: data.directions[indexPath.row].rawValue)
                
            case .compatibleMovements:
                
                cell.directionImageView.isHidden = true
                cell.compatibleMovementLabel.isHidden = false
                cell.compatibleMovementLabel.text = data.compatibleMovements.count == 0 ? "It's not compatible with other movements" : data.compatibleMovements[indexPath.row]
            default:
                break
            }
        
            return cell
        }

        return UICollectionViewCell()
    }
}

