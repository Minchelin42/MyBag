//
//  ProfileNameViewController.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/19.
//

import UIKit

enum ProfileSettingType {
    case new
    case edit
}

class ProfileNameViewController: UIViewController {

    @IBOutlet var profileButton: ProfileButton!
    @IBOutlet var cameraImage: UIImageView!

    @IBOutlet var profileView: UIView!
    
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var underLine: UIView!
    @IBOutlet var checkLabel: UILabel!

    @IBOutlet var completeButton: UIButton!
    
    let viewModel = ProfileModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setBackgroundColor()
        configureView()
        
        viewModel.outputText.bind { value in
            self.checkLabel.text = value
        }
        
        viewModel.selectImage.bind { value in
            self.profileButton.configureView(image: "profile\(value + 1)", isSelected: true)
        }
    }
    
    @objc func completeButtonTapped() {
        print(#function)

        viewModel.isPossible.bind { value in
            if value {
                self.viewModel.editType.bind { value in
                    if value == .new {
                        self.view.endEditing(true)
                        
                        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                        
                        let sceneDelegate = windowScene?.delegate as? SceneDelegate
                        
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        let vc = sb.instantiateViewController(withIdentifier: "mainSearchEmptyTabController") as! UITabBarController
                        
                        sceneDelegate?.window?.rootViewController = vc
                        sceneDelegate?.window?.makeKeyAndVisible()
                        
                        UserDefaultManager.shared.nickName = self.viewModel.inputName.value
                        print(UserDefaultManager.shared.nickName)
                        UserDefaultManager.shared.newMember = false
                    } else {
                        self.view.endEditing(true)
                        
                        let alert = UIAlertController(title: "프로필 수정", message: "수정 내용을 반영하시겠습니까?", preferredStyle: .alert)

                        let cancelButton = UIAlertAction(title: "취소", style: .default)
                        let editButton = UIAlertAction(title: "확인", style: .default) { action in
                            UserDefaultManager.shared.nickName = self.viewModel.inputName.value
                            self.navigationController?.popViewController(animated: true)
                        }

                        alert.addAction(cancelButton)
                        alert.addAction(editButton)
         
                        self.present(alert, animated: true)
                    }
                }
            } else {
                
                let alert = UIAlertController(title: "프로필 등록 실패", message: "닉네임을 다시 확인해주세요!", preferredStyle: .alert)
                
                let button = UIAlertAction(title: "확인", style: .cancel)

                alert.addAction(button)

                self.present(alert, animated: true)
            }
        }

    }

    @objc func leftBarButtonItemClicked() {
        print(#function)
        if viewModel.editType.value == .edit {
            UserDefaultManager.shared.profileIndex = viewModel.selectImage.value
        }
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
  
        viewModel.selectImage.value = UserDefaultManager.shared.profileIndex
    }

    @IBAction func profileImageTapped(_ sender: UIButton) {
        print(#function)

        let sb = UIStoryboard(name: "ProfileImage", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ProfileImageViewController.identifier) as! ProfileImageViewController

        vc.viewModel.editType.value = self.viewModel.editType.value
        navigationController?.pushViewController(vc, animated: true)

    }

    @IBAction func inputFinish(_ sender: UITextField) {
        print(#function)
        view.endEditing(true)
        UserDefaultManager.shared.nickName = viewModel.inputName.value
    }

    @IBAction func isEditing(_ sender: UITextField) {
        print(#function)
        viewModel.inputName.value = self.inputTextField.text!
    }
    
}

extension ProfileNameViewController: ViewProtocol {
    func configureView() {
        
        profileView.backgroundColor = .clear
        
        navigationItem.title = viewModel.editType.value == .new ? "프로필 설정" : "프로필 수정"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        profileButton.configureView(image: ("profile\(viewModel.selectImage.value + 1)"), isSelected: true)
        cameraImage.image = UIImage(named: "camera")
        
        underLine.backgroundColor = .white
        
        viewModel.inputName.value = self.inputTextField.text!
        
        checkLabel.textColor = .pointColor
        checkLabel.font = .systemFont(ofSize: 12)
        
        completeButton.setTitle("완료", for: .normal)
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        

        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(leftBarButtonItemClicked))
        button.tintColor = .white
        navigationItem.leftBarButtonItem = button
    }
}

