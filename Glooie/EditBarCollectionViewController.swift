//
//  EditBarCollectionViewController.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/1/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class EditBarCollectionViewController: UICollectionViewController {
    
    fileprivate let brain = DataModelManager.shared
    
    fileprivate let emptyView: UIView = {
        
        let newView = UIView()
        newView.translatesAutoresizingMaskIntoConstraints = false
        return newView
    }()
    
    fileprivate let emptyViewTitleLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .darkGray
        label.text = "To add new movement, tap and hold in the view above."
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightThin)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emptyView.isHidden = !(brain.movementsSelectedByUser.count == 0)
        
        brain.editBarNeedsUpdate = { [weak self] shouldScroll in
            
            guard let strongSelf = self else { return }
            
            strongSelf.emptyView.isHidden = !(strongSelf.brain.movementsSelectedByUser.count == 0)
            
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureEmptyView()
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
    
    func configureEmptyView() {
        
        emptyView.addSubview(emptyViewTitleLabel)
        view.addSubview(emptyView)
        
        NSLayoutConstraint.activate([
            
            emptyViewTitleLabel.widthAnchor.constraint(equalTo: emptyView.widthAnchor, multiplier: 0.6),
            emptyViewTitleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            emptyViewTitleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
            
            view.topAnchor.constraint(equalTo: emptyView.topAnchor),
            view.bottomAnchor.constraint(equalTo: emptyView.bottomAnchor),
            view.leftAnchor.constraint(equalTo: emptyView.leftAnchor),
            view.rightAnchor.constraint(equalTo: emptyView.rightAnchor)
            ])
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
        print("🍤 \(ad.name), \(String(describing: ad.direction)), \(ad.amountOfRepeats)")
    }
}
