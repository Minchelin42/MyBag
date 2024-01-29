//
//  OptionButton.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/29.
//

import UIKit

class OptionButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configureView(isSelected: Bool) {
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        
        titleLabel?.font = .systemFont(ofSize: 14)
        setTitleColor(isSelected ? .black : .white, for: .normal)
        backgroundColor = isSelected ? .white : .black
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
