//
//  UITableViewExtension.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/13/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit

extension UICollectionView {

    private func findCell(using view: UIView) -> UICollectionViewCell? {
        
        guard let superView = view.superview else { return nil }
        
        switch superView {
        case let cell as UICollectionViewCell:
            return cell
        default:
            return findCell(using: superView)
        }
    }
    
    func indexPath(for view: UIView) -> IndexPath? {
    
        guard let cell = findCell(using: view) else { return nil }
        
        return indexPath(for: cell)
    }
}
