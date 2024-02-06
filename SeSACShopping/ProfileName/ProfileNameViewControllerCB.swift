//
//  ProfileNameViewControllerCB.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/30.
//

import UIKit

enum NicknameError: Error {
    case inputNumber
    case inputSymbol
    case nameLength
    case inputBlank
}

class ProfileNameViewControllerCB: UIViewController {
    
    let profileButton = ProfileButton()
    let cameraImage = UIImageView()
    
    let inputTextField = NameTextField()
    let underLine = UIView()
    let checkLabel = UILabel()

    let completeButton = PointButton()
    
    let symbolList = ["@","#","$","%"]
    let numberList = ["0","1","2","3","4","5","6","7","8","9"]
    
    var symbol = false
    var number = false
    var count = false
    
    var isPossible = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureHierarchy()
        setConstraints()
        configureView()
    }
    
    @objc
    func textFieldEditing() {
        print(#function)
        
        guard let text = inputTextField.text else { return }
        
        do {
            let result = try validateNicknameInputError(name: text)
        } catch {
            switch error {
            case NicknameError.inputSymbol:
                print("특수문자 오류")
            case NicknameError.inputNumber:
                print("숫자 입력 오류")
            case NicknameError.nameLength:
                print("길이범위 오류")
            case NicknameError.inputBlank:
                print("공백 입력 오류")
            default:
                print("알 수 없는 오류!")
            }
        }
    }
    
    func validateNicknameInputError(name: String) throws -> Bool {
        guard !inputTextField.text!.contains(symbolList[0]),
              !inputTextField.text!.contains(symbolList[1]),
              !inputTextField.text!.contains(symbolList[2]),
              !inputTextField.text!.contains(symbolList[3]) else {
            checkLabel.text = "닉네임에 @,#,$,% 는 포함할 수 없어요"
            throw NicknameError.inputSymbol
        }
        
        guard !inputTextField.text!.contains(numberList[0]),
              !inputTextField.text!.contains(numberList[1]),
              !inputTextField.text!.contains(numberList[2]),
              !inputTextField.text!.contains(numberList[3]),
              !inputTextField.text!.contains(numberList[4]),
              !inputTextField.text!.contains(numberList[5]),
              !inputTextField.text!.contains(numberList[6]),
              !inputTextField.text!.contains(numberList[7]),
              !inputTextField.text!.contains(numberList[8]),
              !inputTextField.text!.contains(numberList[9]) else {
            checkLabel.text = "닉네임에 숫자는 포함할 수 없어요"
            throw NicknameError.inputNumber
        }
        
        guard inputTextField.text!.count < 10,
              inputTextField.text!.count > 2 else {
            checkLabel.text = "닉네임은 2글자 이상 10글자 미만으로 설정해주세요"
            throw NicknameError.nameLength
        }
        
        guard !inputTextField.text!.contains(" ") else {
            checkLabel.text = "닉네임에 공백은 입력할 수 없습니다"
            throw NicknameError.inputBlank
        }

        checkLabel.text = ""
        return true
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
            make.width.equalTo(330)
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
        inputTextField.addTarget(self, action: #selector(textFieldEditing), for: .editingChanged)
        
        underLine.backgroundColor = .pointColor
        checkLabel.textColor = .pointColor
        checkLabel.text = ""
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
