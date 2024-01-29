//
//  ProfileImage.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/29.
//

import UIKit

class ProfileImage: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView(){
        layer.borderWidth = 5
        layer.borderColor = UIColor.pointColor.cgColor
        contentMode = .scaleAspectFill
        clipsToBounds = true
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.width / 2
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        fatalError("init(coder:) has not been implemented")
        configureView()
    }
}
