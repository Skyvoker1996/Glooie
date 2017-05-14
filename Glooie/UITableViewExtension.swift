//
//  UITableViewExtension.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/14/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit

extension UITableView {
    
    private func findCell(using view: UIView) -> UITableViewCell? {
        
        guard let superView = view.superview else { return nil }
        
        switch superView {
        case let cell as UITableViewCell:
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
