//
//  UIColorExtension.swift
//  Glooie
//
//  Created by Michael Gerasimov on 4/24/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit

extension UIColor {
    
    class var primary: UIColor {
        
        return UIColor(r: 53, g: 145, b: 112)
    }
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
