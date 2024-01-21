//
//  SettingTableViewCell.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/19.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    @IBOutlet var settingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .darkGrayColor
        
        settingLabel.font = .systemFont(ofSize: 13)
        settingLabel.textColor = .textColor
    }
    
}
