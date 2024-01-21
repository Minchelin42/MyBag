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
    
    func pointButtonStyle(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.textColor, for: .normal)
        self.titleLabel?.font = .boldSystemFont(ofSize: 17)
        
        self.backgroundColor = .pointColor
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
    
    func profileButtonStyle(image: String, isSelected: Bool){
        self.setImage(UIImage(named: image), for: .normal)
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
        if isSelected {
            self.layer.borderWidth = 5
            self.layer.borderColor = UIColor.pointColor.cgColor
        } else {
            self.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    func optionButtonStyle(title: String, isSelected: Bool){
        
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 14)
        self.setTitleColor(isSelected ? .black : .white, for: .normal)
        self.backgroundColor = isSelected ? .white : .black
    }
    
    func heartButtonStyle(isSelected: Bool){
        self.layer.cornerRadius = self.frame.width / 2
        self.backgroundColor = .white
        self.setImage(UIImage(systemName: isSelected ? "suit.heart.fill" : "suit.heart"), for: .normal)
        self.tintColor = .black
    }
    
}

extension UIImageView {
    func profileImageStyle(image: String, isSelected: Bool){
        self.image = UIImage(named: image)
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.pointColor.cgColor
    }
}

extension UISearchBar {
    func blackSearchBarStyle() {
        self.barTintColor = .backgroudnColor
        self.searchTextField.textColor = .textColor
        self.searchTextField.backgroundColor = .darkGrayColor
        self.searchTextField.attributedPlaceholder = NSAttributedString(string: "브랜드, 상품, 프로필, 태그 등", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    }
}

protocol ViewProtocol {
    func configureView()
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

