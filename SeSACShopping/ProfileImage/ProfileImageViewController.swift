//
//  ProfileImageViewController.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/19.
//

import UIKit

class ProfileImageViewController: UIViewController {

    @IBOutlet var selectImage: UIImageView!
    @IBOutlet var imageList: [ProfileButton]!
    
    let viewModel = ProfileModel()
    
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
        let selectButton = imageList[self.viewModel.selectImage.value]
        
        sender.isSelected.toggle()
        selectButton.isSelected.toggle()
    
        selectButton.configureView(image: "profile\(self.viewModel.selectImage.value + 1)", isSelected: selectButton.isSelected)
        
        self.viewModel.selectImage.value = index
        
        viewModel.selectImage.bind { value in
            print("으아아아아아아ㅏ앙")
            self.imageList[value].configureView(image: "profile\(value + 1)", isSelected: sender.isSelected)
            UserDefaultManager.shared.profileIndex = value
            
            self.selectImage.image = UIImage(named: "profile\(value + 1)")
        }

    }
    
}

extension ProfileImageViewController: ViewProtocol {
    func configureView() {
        navigationItem.title = self.viewModel.editType.value == .new ? "프로필 설정" : "프로필 수정"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        selectImage.image = UIImage(named: "profile\(self.viewModel.selectImage.value + 1)")
        
        for index in 0...imageList.count - 1 {
            
            imageList[index].tag = index
            
            if index == self.viewModel.selectImage.value {
                imageList[index].isSelected = true

                imageList[index].configureView(image: "profile\(index + 1)", isSelected: true)
            } else {
                imageList[index].configureView(image: "profile\(index + 1)", isSelected: false)
            }
        }
    }
}
