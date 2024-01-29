//
//  ResultCollectionViewCell.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/19.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet var resultImage: UIImageView!

    @IBOutlet var heartButton: HeartButton!
    
    @IBOutlet var companyLabel: UILabel!
    @IBOutlet var productLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resultImage.layer.cornerRadius = 20
        resultImage.contentMode = .scaleAspectFill
        
        heartButton.configureView(isSelected: heartButton.isSelected)
        
        companyLabel.textColor = .lightGray
        companyLabel.font = .systemFont(ofSize: 13, weight: .regular)
        
        productLabel.textColor = .textColor
        productLabel.font = .systemFont(ofSize: 14, weight: .regular)
        productLabel.numberOfLines = 2
        
        priceLabel.textColor = .textColor
        priceLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
    }

}
