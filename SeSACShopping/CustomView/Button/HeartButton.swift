//
//  HeartButton.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/29.
//

import UIKit

class HeartButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configureView(isSelected: Bool) {
        layer.cornerRadius = self.frame.width / 2
        backgroundColor = .white
        setImage(UIImage(systemName: isSelected ? "suit.heart.fill" : "suit.heart"), for: .normal)
        tintColor = .black
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
