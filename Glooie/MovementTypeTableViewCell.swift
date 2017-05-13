//
//  MovementTypeTableViewCell.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/11/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

class MovementTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var movementTypeImageView: UIImageView!
    @IBOutlet weak var movementTypeLabel: UILabel!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var innerStackView: UIStackView!
    @IBOutlet weak var outerStackView: UIStackView!
    @IBOutlet weak var bottomStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: 40, height: 40)
        layout.scrollDirection = .horizontal
        layout.sideItemScale = 0.6
        layout.sideItemAlpha = 0.6
        collectionView.collectionViewLayout = layout
    }
    
    var movementType: MovementType = MovementType(json: []) {
        
        didSet {
            
            
            switch movementType.type {
            case .catchLocation:
                
                accessoryType = .none
                heightConstraint.constant = 40
                bottomStackView.spacing = 10
                innerStackView.arrangedSubviews.first?.isHidden = true
                outerStackView.arrangedSubviews.last?.isHidden = false
                collectionView.reloadData()
            default:
            
                accessoryType = .disclosureIndicator
                bottomStackView.spacing = 0
                heightConstraint.constant = 0
                innerStackView.arrangedSubviews.first?.isHidden = false
                outerStackView.arrangedSubviews.last?.isHidden = true
            }
            
            movementTypeLabel.text = movementType.type.rawValue
            movementTypeImageView.image = movementType.image
        }
    }
}

extension MovementTypeTableViewCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("🍐 Currenty selected items is under index \(indexPath.row)")
    }
}

extension MovementTypeTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movementType.directions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.directionCollectionCell.rawValue, for: indexPath) as? DirectionCollectionViewCell {
            
            let imageName = movementType.directions[indexPath.row].rawValue
            cell.directionImageView.image = UIImage(named: imageName)
            return cell
        }
        
        return UICollectionViewCell()
    }
}
