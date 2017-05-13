//
//  EditBarCollectionViewController.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/1/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class EditBarCollectionViewController: UICollectionViewController {
    
    fileprivate let brain = DataModelBrain.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        brain.editBarNeedsUpdate = { [weak self] shouldScroll in
            
            guard let strongSelf = self else { return }
            
            strongSelf.collectionView?.performBatchUpdates({
                
                strongSelf.collectionView?.reloadSections(IndexSet(integer: 0))
            }) { _ in
                
                guard shouldScroll else { return }
                
                strongSelf.collectionView?.scrollToItem(at: IndexPath(item: strongSelf.brain.movementsSelectedByUser.count - 1, section: 0), at: .right, animated: true)
            }
        }
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(reorderItem(recognizer:)))
        collectionView?.addGestureRecognizer(longPressGesture)
    }
    
    func reorderItem(recognizer: UILongPressGestureRecognizer) {
        
        switch recognizer.state {
            
        case .began:
            guard let selectedIndexPath = collectionView?.indexPathForItem(at: recognizer.location(in: collectionView)) else { return }
            
            collectionView?.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView?.updateInteractiveMovementTargetPosition(recognizer.location(in: recognizer.view))
        case .ended:
            collectionView?.endInteractiveMovement()
        default:
            collectionView?.cancelInteractiveMovement()
        }
    }
}

// MARK: - Data Source methods
extension EditBarCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brain.movementsSelectedByUser.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.editBarCollectionCell.rawValue, for: indexPath) as? EditBarCollectionViewCell {
            
            cell.delegate = self
            cell.movement = brain.movementsSelectedByUser[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        (brain.movementsSelectedByUser[destinationIndexPath.row], brain.movementsSelectedByUser[sourceIndexPath.row]) = (brain.movementsSelectedByUser[sourceIndexPath.row], brain.movementsSelectedByUser[destinationIndexPath.row])
    }
}

extension EditBarCollectionViewController: EditBarCollectionViewCellDelegate {
    
    func itemNeedsToBeDeleted(_ sender: UIButton) {
        
        guard let indexPath = collectionView?.indexPath(for: sender) else { return }
        
        brain.movementsSelectedByUser.remove(at: indexPath.row)
    }
    
    func updateAmountOfRepeats(to value: Int, with sender: UIView) {
        
        guard let indexPath = collectionView?.indexPath(for: sender) else { return }
        
        brain.movementsSelectedByUser[indexPath.row].amountOfRepeats = value
        
        let ad = brain.movementsSelectedByUser[indexPath.row]
        print("🍤 \(ad.name), \(ad.direction), \(ad.amountOfRepeats)")
    }
}
