//
//  ProfileNameViewControllerCB.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/30.
//

import UIKit

enum NicknameError: Error {
    case inputNumber
    case inputSpecial
    case lengthError
}

class ProfileNameViewControllerCB: UIViewController {
    
    let profileButton = ProfileButton()
    let cameraImage = UIImageView()
    
    let inputTextField = NameTextField()
    let underLine = UIView()
    let checkLabel = UILabel()

    let completeButton = PointButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureHierarchy()
        setConstraints()
        configureView()
    }
    
    func configureHierarchy() {

        view.addSubview(profileButton)
        view.addSubview(cameraImage)
        
        view.addSubview(inputTextField)
        view.addSubview(underLine)
        view.addSubview(checkLabel)
        
        view.addSubview(completeButton)
        
    }
    
    func setConstraints() {
        profileButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.centerX.equalTo(view)
            make.size.equalTo(120)
        }
        
        cameraImage.snp.makeConstraints { make in
            make.trailing.equalTo(profileButton.snp.trailing).inset(5)
            make.bottom.equalTo(profileButton.snp.bottom).inset(5)
            make.size.equalTo(35)
        }
        
        inputTextField.snp.makeConstraints { make in
            make.top.equalTo(profileButton.snp.bottom).offset(70)
            make.centerX.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(40)
        }
        
        underLine.snp.makeConstraints { make in
            make.top.equalTo(inputTextField.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(360)
            make.height.equalTo(1)
        }
        
        checkLabel.snp.makeConstraints { make in
            make.top.equalTo(underLine.snp.bottom).offset(5)
            make.width.equalTo(200)
            make.height.equalTo(20)
            make.leading.equalTo(22)
        }
        
        completeButton.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func configureView() {
        profileButton.configureView(image: "profile1", isSelected: true)
        cameraImage.image = UIImage(named: "camera")
        inputTextField.backgroundColor = .black
        underLine.backgroundColor = .pointColor
        checkLabel.textColor = .pointColor
        checkLabel.text = "닉네임을 입력해주세요"
        checkLabel.font = .systemFont(ofSize: 13, weight: .regular)
        completeButton.backgroundColor = .pointColor
        completeButton.setTitle("완료", for: .normal)
        completeButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        completeButton.clipsToBounds = true
        completeButton.layer.cornerRadius = 5
    }

}

#Preview {
    ProfileNameViewControllerCB()
}
