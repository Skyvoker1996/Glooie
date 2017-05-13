//
//  BasicHeaderCollectionReusableView.swift
//  Glooie
//
//  Created by Michael Gerasimov on 5/13/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class BasicHeaderCollectionReusableView: UICollectionReusableView {
    
    var titleLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .primary
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightLight)
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            
            topAnchor.constraint(equalTo: titleLabel.topAnchor),
            bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            rightAnchor.constraint(equalTo: titleLabel.rightAnchor)
            ])
    }
}
