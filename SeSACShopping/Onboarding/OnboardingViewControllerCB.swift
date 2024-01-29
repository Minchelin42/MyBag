//
//  OnboardingViewControllerCB.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/30.
//

import UIKit
import SnapKit

class OnboardingViewControllerCB: UIViewController {
    
    let shoppingLogoImage = UIImageView()
    let shoppingMainImage = UIImageView()
    let startButton = PointButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureHierarchy()
        setConstraints()
        configureView()

    }
    
    func configureHierarchy() {
        view.addSubview(shoppingLogoImage)
        view.addSubview(shoppingMainImage)
        view.addSubview(startButton)
    }
    
    func setConstraints() {
        shoppingLogoImage.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(70)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
        }
        
        shoppingMainImage.snp.makeConstraints { make in
            make.size.equalTo(293)
            make.top.equalTo(shoppingLogoImage.snp.bottom).offset(60)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        
        startButton.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func configureView() {
        shoppingLogoImage.image = UIImage(named: "sesacShopping")
        shoppingLogoImage.contentMode = .scaleAspectFit
        
        shoppingMainImage.image = UIImage(named: "onboarding")
        shoppingMainImage.contentMode = .scaleAspectFit
        
        startButton.setTitle("시작하기", for: .normal)
        
    }
    
}

#Preview {
    OnboardingViewControllerCB()
}
