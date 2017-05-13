//
//  MovementTableViewCell.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/12/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit

protocol MovementTableViewCellDelegate: class {
    
    func userSelected(movement: Movement)
}

class MovementTableViewCell: UITableViewCell {

    @IBOutlet weak var movementTitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    enum DataType {
        
        case directions
        case compatibleMovements
        case none
    }
    
    weak var delegate: MovementTableViewCellDelegate?
    
    var dataTypes: [MovementTableViewCell.DataType] = [.compatibleMovements] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    var movements: [Movement] = [] {
        didSet {
            
            guard let movement = movements.first else { return }
            
            movementTitleLabel.text = movement.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        collectionView.register(BasicHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Headers.basicCollectionViewHeader.rawValue)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension MovementTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 30)
    }
}

extension MovementTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionElementKindSectionHeader else { return UICollectionReusableView() }
        
        if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Headers.basicCollectionViewHeader.rawValue, for: indexPath) as? BasicHeaderCollectionReusableView {
            
            
            switch dataTypes[indexPath.section] {
            case .compatibleMovements:
                
                headerView.titleLabel.text = "Compatible movements:"
            case .directions:
                
                headerView.titleLabel.text = "Select direction:"
            default:
                break
            }
            
            return headerView
        }
        
        return UICollectionReusableView()
    }
}

extension MovementTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return dataTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.movementSelectionCollectionCell.rawValue, for: indexPath) as? MovementSelectionCollectionViewCell {
            
            cell.dataType = dataTypes[indexPath.section]
            cell.delegate = self
            
            switch cell.dataType {
            case .compatibleMovements:
                
                cell.data = (movements.first?.compatibleMovements ?? [], [])
            case .directions:
            
                cell.data = ([], movements.flatMap { $0.direction })
            default:
                break
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension MovementTableViewCell: MovementSelectionCollectionViewCellDelegate {
    
    func didSelect(direction: DirectionNames) {
        
        let selectedMovement = movements.filter { $0.direction == direction }.first
        
        guard selectedMovement != nil else { return }
        
        delegate?.userSelected(movement: selectedMovement!)
    }
}

