//
//  ProfileButton.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/29.
//

import UIKit

class ProfileButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configureView(image: String, isSelected: Bool) {
        setImage(UIImage(named: image), for: .normal)
        clipsToBounds = true
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.width / 2
        }
        if isSelected {
            layer.borderWidth = 5
            layer.borderColor = UIColor.pointColor.cgColor
        } else {
            layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
