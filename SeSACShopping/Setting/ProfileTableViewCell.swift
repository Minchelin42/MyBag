//
//  ProfileTableViewCell.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/20.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var likeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .darkGrayColor

        nameLabel.textColor = .textColor
        nameLabel.font = .boldSystemFont(ofSize: 16)

        countLabel.textColor = .pointColor
        countLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        
        likeLabel.text = "을 좋아하고 있어요!"
        likeLabel.textColor = .textColor
        likeLabel.font = .systemFont(ofSize: 15, weight: .semibold)

        
    }

}
