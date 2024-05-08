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
    
    var selectIndex = 0
    
    var type: ProfileSettingType = .new
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
        configureView()
        
        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(leftBarButtonItemClicked))
        button.tintColor = .white
        navigationItem.leftBarButtonItem = button
    }

    @objc func leftBarButtonItemClicked() {
        print(#function)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func imageTapped(_ sender: UIButton) {

        let index = sender.tag
        let selectButton = imageList[selectIndex]
        
        sender.isSelected.toggle()
        selectButton.isSelected.toggle()
        
        selectButton.profileButtonStyle(image: "profile\(selectIndex + 1)", isSelected: selectButton.isSelected)
        imageList[index].profileButtonStyle(image: "profile\(index + 1)", isSelected: sender.isSelected)
        
        selectIndex = index
        UserDefaultManager.shared.profileIndex = selectIndex
        
        selectImage.profileImageStyle(image: "profile\(selectIndex + 1)", isSelected: true)

    }
    
}

extension ProfileImageViewController: ViewProtocol {
    func configureView() {
        navigationItem.title = type == .new ? "프로필 설정" : "프로필 수정"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
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
}
