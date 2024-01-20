//
//  SearchLogTableViewCell.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/19.
//

import UIKit

class SearchLogTableViewCell: UITableViewCell {
    
    
    @IBOutlet var leftImage: UIImageView!
    @IBOutlet var circleView: UIView!
    @IBOutlet var searchLogLabel: UILabel!
    @IBOutlet var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
        circleView.layer.cornerRadius = circleView.frame.width / 2
        circleView.layer.borderWidth = 1
        circleView.layer.borderColor = UIColor.darkGrayColor.cgColor
        circleView.backgroundColor = .clear
        
        leftImage.image = UIImage(systemName: "magnifyingglass")
        leftImage.tintColor = .textColor

        searchLogLabel.textColor = .textColor
        searchLogLabel.font = .systemFont(ofSize: 14)
        
        deleteButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        deleteButton.tintColor = .gray
        
        deleteButton.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
    }
    
    @objc func selectButtonTapped(sender: UIButton) {
        print(#function)
        print(sender.tag)
        // MARK: - 버튼 작동 확인용 -> list 삭제로 변경
        sender.tintColor = .white
    }

}
