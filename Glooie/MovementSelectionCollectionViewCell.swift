//
//  MovementSelectionCollectionViewCell.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/12/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

class MovementSelectionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataType: DataType = .none {
        
        didSet {
            
            let layout = UPCarouselFlowLayout()
            
            switch dataType {
            case .compatibleMovements:
                layout.itemSize = CGSize(width: 60, height: 30)
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
    
    var compatibleMovements = [String]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    enum DataType {
        
        case directions
        case compatibleMovements
        case none
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
        
        print("🌳")
    }
}

extension MovementSelectionCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataType == .directions ? 2 : compatibleMovements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.contentCollectionCell.rawValue, for: indexPath)
        
        func addConstraints(to view: UIView) {
            
            view.translatesAutoresizingMaskIntoConstraints = false
            cell.addSubview(view)
            
            NSLayoutConstraint.activate([
                
                view.topAnchor.constraint(equalTo: cell.topAnchor),
                view.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
                view.leftAnchor.constraint(equalTo: cell.leftAnchor),
                view.rightAnchor.constraint(equalTo: cell.rightAnchor)
                ])
        }
        
        switch dataType {
        case .directions:
            let imageView = UIImageView(image: #imageLiteral(resourceName: "up"))
            imageView.contentMode = .scaleAspectFit
            
            addConstraints(to: imageView)
        case .compatibleMovements:
            
            let label = UILabel()
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightLight)
            label.textColor = .lightGray
            label.text = compatibleMovements[indexPath.row]
            addConstraints(to: label)
        default:
            break
        }
            
        return cell
    }
}

