//
//  MainSearchEmptyViewController.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/19.
//

import UIKit
import Alamofire

class MainSearchEmptyViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var emptyImage: UIImageView!
    @IBOutlet var emptyLabel: UILabel!
    
    var nickName = UserDefaultManager.shared.nickName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroudnColor
        
        navigationItem.title = "\(nickName)님의 새싹쇼핑"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        
        searchBar.blackSearchBarStyle()

        emptyImage.image = UIImage(named: "empty")
        
        emptyLabel.text = "최근 검색어가 없어요"
        emptyLabel.font = .boldSystemFont(ofSize: 17)
        emptyLabel.textColor = .textColor
        
        searchBar.delegate = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        navigationItem.title = "\(UserDefaultManager.shared.nickName)님의 새싹쇼핑"
        
        if !UserDefaultManager.shared.searchItems.isEmpty {
            
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            let rootSb = UIStoryboard(name: "Main", bundle: nil)
            let rootVc = rootSb.instantiateViewController(withIdentifier: "mainSearchTabController") as! UITabBarController
            
            sceneDelegate?.window?.rootViewController = rootVc
            sceneDelegate?.window?.makeKeyAndVisible()
        }
    }

}

extension MainSearchEmptyViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        if !searchBar.text!.isEmpty {
            
            UserDefaultManager.shared.searchItems.append(searchBar.text!)
            print(UserDefaultManager.shared.searchItems)
            
            let sb = UIStoryboard(name: "SearchResult", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController
            
            vc.searchItem = searchBar.text!
            
            searchBar.text = ""
            view.endEditing(true)
            navigationController?.pushViewController(vc, animated: true)

        } else {

            let alert = UIAlertController(title: "검색어를 입력해주세요", message: nil, preferredStyle: .alert)

            let button = UIAlertAction(title: "확인", style: .cancel)

            alert.addAction(button)
            present(alert, animated: true)
        }
        
    }
}
