//
//  BlackSearchBar.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/29.
//

import UIKit

class BlackSearchBar: UISearchBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        barTintColor = .backgroudnColor
        searchTextField.textColor = .textColor
        searchTextField.backgroundColor = .darkGrayColor
        searchTextField.attributedPlaceholder = NSAttributedString(string: "브랜드, 상품, 프로필, 태그 등", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }

}



