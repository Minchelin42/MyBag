//
//  OnboardingViewController.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/19.
//

import UIKit
import RealmSwift

class OnboardingViewController: UIViewController {

    @IBOutlet var logoImage: UIImageView!
    @IBOutlet var onboardingImage: UIImageView!
    @IBOutlet var startButton: UIButton!
    
    let realm = try! Realm()
    var wishList: Results<WishListTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        setBackgroundColor()
        configureView()
        
        wishList = realm.objects(WishListTable.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        resetData()
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        print(#function)
        
        let sb = UIStoryboard(name: "ProfileName", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ProfileNameViewController.identifier) as! ProfileNameViewController
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func resetData() {
        UserDefaultManager.shared.profileIndex = Int.random(in: 0...13)
        UserDefaultManager.shared.nickName = ""
        UserDefaultManager.shared.searchItems.removeAll()
        UserDefaultManager.shared.likeItems.removeAll()
        do {
            try realm.write {
                realm.delete(self.wishList)
            }
        } catch {
            print(error)
        }
        UserDefaultManager.shared.newMember = true
    }
    
}


extension OnboardingViewController: ViewProtocol {
    func configureView() {
        logoImage.image = UIImage(named: "sesacShopping")
        onboardingImage.image = UIImage(named: "onboarding")

        startButton.setTitle("시작하기", for: .normal)
    }
}
