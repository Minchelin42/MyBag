//
//  SettingViewController.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/19.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet var settingTableView: UITableView!
    
    // MARK: - userProfile 저장한 곳에서 가져와야함
    let profileImg = "profile1"
    let likeCount = 10
    let nickName = "떠나고싶은 고래밥"
    
    let settingList = ["공지사항", "자주 묻는 질문", "1:1 문의", "알림 설정","처음부터 시작하기"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroudnColor
        settingTableView.backgroundColor = .clear
        
        navigationItem.title = "설정"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        
        configureTableView()

    }

}

extension SettingViewController {
    func configureTableView() {
        settingTableView.delegate = self
        settingTableView.dataSource = self
        
        let xib = UINib(nibName: ProfileTableViewCell.identifier, bundle: nil)
        settingTableView.register(xib, forCellReuseIdentifier: ProfileTableViewCell.identifier)

        
        let xib2 = UINib(nibName: SettingTableViewCell.identifier, bundle: nil)
        settingTableView.register(xib2, forCellReuseIdentifier: SettingTableViewCell.identifier)
        
        settingTableView.allowsSelection = false
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 95
        } else {
            return 50
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return settingList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
            
            cell.profileImage.profileImageStyle(image: "\(profileImg)", isSelected: true)
            
            cell.nameLabel.text = "\(nickName)"
            cell.countLabel.text = "\(likeCount)개의 상품"
            cell.likeLabel.text = "을 좋아하고 있어요!"

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
            
            cell.settingLabel.text = "\(settingList[indexPath.row])"

            return cell
        }
    }
    
    
}
