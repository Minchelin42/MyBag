//
//  ProfileImageViewController.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/19.
//

import UIKit

class ProfileImageViewController: UIViewController {

    @IBOutlet var selectImage: UIImageView!
    @IBOutlet var imageList: [UIButton]!
    
    // MARK: - 이전 view에서 index 받아와야 함
    var selectIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroudnColor
        
        selectImage.profileImageStyle(image: "profile\(selectIndex + 1)", isSelected: true)
        
        for index in 0...imageList.count - 1 {
            
            imageList[index].tag = index
            
            if index == selectIndex {
                imageList[index].isSelected = true
                imageList[index].profileButtonStyle(image: "profile\(index + 1)", isSelected: true)
            } else {
                imageList[index].profileButtonStyle(image: "profile\(index + 1)", isSelected: false)
            }
        }

    }

    // MARK: - 바뀐 index값을 이전 view로 데이터 전달 필요
    @IBAction func imageTapped(_ sender: UIButton) {

        let index = sender.tag
        let selectButton = imageList[selectIndex]
        
        sender.isSelected.toggle()
        selectButton.isSelected.toggle()
        
        selectButton.profileButtonStyle(image: "profile\(selectIndex + 1)", isSelected: selectButton.isSelected)
        imageList[index].profileButtonStyle(image: "profile\(index + 1)", isSelected: sender.isSelected)
        
        selectIndex = index
        
        selectImage.profileImageStyle(image: "profile\(selectIndex + 1)", isSelected: true)

    }
    
}
