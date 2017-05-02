//
//  UITableViewControllerExtension.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/2/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit

extension UITableViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = GlobalConfig.NavBarAttributes
    }
}
