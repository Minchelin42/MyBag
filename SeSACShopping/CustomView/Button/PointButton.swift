//
//  PointButton.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/29.
//

import UIKit

class PointButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        setTitleColor(.textColor, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 17)
        
        backgroundColor = .pointColor
        clipsToBounds = true
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
}

