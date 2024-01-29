//
//  NameTextField.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/29.
//

import UIKit

class NameTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        backgroundColor = .backgroudnColor
        borderStyle = .none
        textColor = .textColor
        font = .systemFont(ofSize: 14)
        text = UserDefaultManager.shared.nickName
        attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해주세요 :)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
}
