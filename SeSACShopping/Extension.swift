//
//  Color.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/20.
//

import UIKit

extension Int {
    var prettyNumber: String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        formatter.locale = .init(identifier: "ko")
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}

extension UIColor {
    static let pointColor = UIColor(red: 0.282, green: 0.863, blue: 0.573, alpha: 1)
    static let backgroudnColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
    static let textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
    static let darkGrayColor = UIColor(red: 0.11, green: 0.11, blue: 0.123, alpha: 1)
}

extension UIButton {
    static var isSelected: Bool = false
}

protocol ReusableProtocol {
    static var identifier: String { get }
}

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController: ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController {
    func setBackgroundColor() {
        view.backgroundColor = .backgroudnColor
    }
}

