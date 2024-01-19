//
//  ProfileNameViewController.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/19.
//

import UIKit

class ProfileNameViewController: UIViewController {

    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var cameraImage: UIImageView!

    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var underLine: UIView!
    @IBOutlet var checkLabel: UILabel!

    @IBOutlet var completeButton: UIButton!
    
    let image = "profile\(Int.random(in: 1...14))"
    let message = "사용할 수 있는 닉네임이에요"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroudnColor

        profileImage.image = UIImage(named: image)
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.layer.borderWidth = 5
        profileImage.layer.borderColor = UIColor.pointColor.cgColor
        cameraImage.image = UIImage(named: "camera")
        
        inputTextField.backgroundColor = .backgroudnColor
        inputTextField.borderStyle = .none
        inputTextField.textColor = .textColor
        inputTextField.font = .systemFont(ofSize: 14)
        inputTextField.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해주세요 :)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        underLine.backgroundColor = .white
        
        checkLabel.text = "\(message)"
        checkLabel.textColor = .pointColor
        checkLabel.font = .systemFont(ofSize: 12)
        
        completeButton.pointButtonStyle(title: "완료")

    }

}
