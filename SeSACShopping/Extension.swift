//
//  Color.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/20.
//

import UIKit

extension UIColor {
    static let pointColor = UIColor(red: 0.282, green: 0.863, blue: 0.573, alpha: 1)
    static let backgroudnColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
    static let textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
}

extension UIButton {
    func pointButtonStyle(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.textColor, for: .normal)
        self.titleLabel?.font = .boldSystemFont(ofSize: 17)
        
        self.backgroundColor = .pointColor
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
}
