//
//  ProfileNameViewController.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/19.
//

import UIKit

class ProfileNameViewController: UIViewController {

    
    @IBOutlet var profileButton: UIButton!
    @IBOutlet var cameraImage: UIImageView!

    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var underLine: UIView!
    @IBOutlet var checkLabel: UILabel!

    @IBOutlet var completeButton: UIButton!

    let symbolList = ["@","#","$","%"]
    let numberList = ["0","1","2","3","4","5","6","7","8","9"]
    
    var symbol = false
    var number = false
    var count = false
    
    var isPossible = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaultManager.shared.profileIndex = Int.random(in: 0...13)
        
        let image = "profile\(UserDefaultManager.shared.profileIndex + 1)"
        view.backgroundColor = .backgroudnColor
        
        navigationItem.title = "프로필 설정"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        profileButton.profileButtonStyle(image: image, isSelected: true)
        cameraImage.image = UIImage(named: "camera")
        
        inputTextField.backgroundColor = .backgroudnColor
        inputTextField.borderStyle = .none
        inputTextField.textColor = .textColor
        inputTextField.font = .systemFont(ofSize: 14)
        inputTextField.text = UserDefaultManager.shared.nickName
        inputTextField.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해주세요 :)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        underLine.backgroundColor = .white
        
        checkName()
        checkLabel.textColor = .pointColor
        checkLabel.font = .systemFont(ofSize: 12)
        
        completeButton.pointButtonStyle(title: "완료")
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        

        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(leftBarButtonItemClicked))
        button.tintColor = .white
        navigationItem.leftBarButtonItem = button
    }
    
    @objc func completeButtonTapped() {
        print(#function)
        
        if isPossible {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "mainSearchEmptyTabController") as! UITabBarController

            sceneDelegate?.window?.rootViewController = vc
            sceneDelegate?.window?.makeKeyAndVisible()
            
            UserDefaultManager.shared.nickName = inputTextField.text!
            print(UserDefaultManager.shared.nickName)
            UserDefaultManager.shared.newMember = false
            
        } else {

            let alert = UIAlertController(title: "프로필 등록 실패", message: "닉네임을 다시 확인해주세요!", preferredStyle: .alert)
            
            let button = UIAlertAction(title: "확인", style: .cancel)

            alert.addAction(button)

            present(alert, animated: true)
        }

    }

    @objc func leftBarButtonItemClicked() {
        print(#function)
        
        UserDefaultManager.shared.profileIndex = Int.random(in: 0...13)
        UserDefaultManager.shared.nickName = ""
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
  
        let image = "profile\(UserDefaultManager.shared.profileIndex + 1)"

        profileButton.profileButtonStyle(image: image, isSelected: true)
        
    }

    @IBAction func profileImageTapped(_ sender: UIButton) {
        print(#function)

        let sb = UIStoryboard(name: "ProfileImage", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ProfileImageViewController.identifier) as! ProfileImageViewController
        vc.selectIndex = UserDefaultManager.shared.profileIndex
        navigationController?.pushViewController(vc, animated: true)

    }

    @IBAction func inputFinish(_ sender: UITextField) {
        print(#function)
        view.endEditing(true)
        
        UserDefaultManager.shared.nickName = inputTextField.text!
    }

    @IBAction func isEditing(_ sender: UITextField) {
        print(#function)
        checkName()
    }
    
    func checkName() {
        
        for index in 0...symbolList.count - 1 {
            if inputTextField.text!.contains(symbolList[index]) {
                checkLabel.text = "닉네임에 @,#,$,% 는 포함할 수 없어요"
                symbol = true
                break
            }
            symbol = false
        }
        
        for index in 0...numberList.count - 1 {
            if inputTextField.text!.contains(numberList[index]) {
                checkLabel.text = "닉네임에 숫자는 포함할 수 없어요"
                number = true
                break
            }
            number = false
        }
        
        // 2가지 조건에 모두 다 해당될 경우 마지막 input값에 따라 불가능한 조건 표시
        var lastInput = ""
        
        if !(inputTextField.text!.isEmpty) {
            lastInput = String(inputTextField.text!.last!)
        }
        
        if symbolList.contains(lastInput){
            checkLabel.text = "닉네임에 @,#,$,% 는 포함할 수 없어요"
        }

        if numberList.contains(lastInput){
            checkLabel.text = "닉네임에 숫자는 포함할 수 없어요"
        }

        if inputTextField.text!.count > 10 || inputTextField.text!.count < 2{
            checkLabel.text = "닉네임은 2글자 이상 10글자 미만으로 설정해주세요"
            count = true
        } else {
            count = false
        }
        
        if !symbol && !number && !count{
            checkLabel.text = "사용 가능한 닉네임입니다"
            isPossible = true
        } else {
            isPossible = false
        }

    }
    
}
