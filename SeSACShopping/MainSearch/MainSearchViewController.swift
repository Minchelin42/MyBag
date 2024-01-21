//
//  MainSearchViewController.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/19.
//

import UIKit

class MainSearchViewController: UIViewController {

    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var searchListTopView: UIView!
    @IBOutlet var leftLabel: UILabel!
    @IBOutlet var listClearButton: UIButton!
    
    @IBOutlet var listTableView: UITableView!
    
    let nickName = UserDefaultManager.shared.nickName
    var searchList = UserDefaultManager.shared.searchItems
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroudnColor
        
        navigationItem.title = "\(nickName)님의 새싹쇼핑"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        searchBar.blackSearchBarStyle()
        
        searchListTopView.backgroundColor = .backgroudnColor
        
        leftLabel.text = "최근 검색"
        leftLabel.font = .boldSystemFont(ofSize: 15)
        leftLabel.textColor = .textColor
        
        listClearButton.setTitle("모두 지우기", for: .normal)
        listClearButton.setTitleColor(.pointColor, for: .normal)
        listClearButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        
        listTableView.backgroundColor = .clear
        
        configureTableView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchList = UserDefaultManager.shared.searchItems
        searchBar.text = ""
        listTableView.reloadData()
    }
    
    // MARK: - 최근 검색 테이블 셀 모두 지우기
    @IBAction func listClearButtonTapped(_ sender: UIButton) {
        print(#function)
        UserDefaultManager.shared.searchItems.removeAll()
        searchList = UserDefaultManager.shared.searchItems
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "mainSearchEmptyTabController") as! UITabBarController

        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
}

extension MainSearchViewController {
    func configureTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
        
        let xib = UINib(nibName: SearchLogTableViewCell.identifier, bundle: nil)
        listTableView.register(xib, forCellReuseIdentifier: SearchLogTableViewCell.identifier)
        
//        listTableView.allowsSelection = false
    }
}

extension MainSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        if !searchBar.text!.isEmpty {
            UserDefaultManager.shared.searchItems.append(searchBar.text!)
            print(UserDefaultManager.shared.searchItems)
            
            let sb = UIStoryboard(name: "SearchResult", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController
            
            vc.searchItem = searchBar.text!
            navigationController?.pushViewController(vc, animated: true)
            
            view.endEditing(true)
            
        } else {

            let alert = UIAlertController(title: "검색어를 입력해주세요", message: nil, preferredStyle: .alert)

            let button = UIAlertAction(title: "확인", style: .cancel)

            alert.addAction(button)
            present(alert, animated: true)
        }
        
    }
}

extension MainSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchLogTableViewCell.identifier, for: indexPath) as! SearchLogTableViewCell
        
        let cellIndex = searchList.count - indexPath.row - 1
        cell.searchLogLabel.text = "\(searchList[cellIndex])"
        
        cell.backgroundColor = .backgroudnColor
        cell.deleteButton.tag = indexPath.row
        
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return cell
    }
    
    @objc func deleteButtonTapped(sender: UIButton) {
        print(#function)

        UserDefaultManager.shared.searchItems.remove(at: searchList.count - sender.tag - 1)
        searchList = UserDefaultManager.shared.searchItems
        
        if searchList.isEmpty {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "mainSearchEmptyTabController") as! UITabBarController

            sceneDelegate?.window?.rootViewController = vc
            sceneDelegate?.window?.makeKeyAndVisible()
        } else {
            listTableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "SearchResult", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController
        
        vc.searchItem = searchList[searchList.count - indexPath.row - 1] as! String
        searchList.remove(at: searchList.count - indexPath.row - 1)
        searchList.append(vc.searchItem)
        UserDefaultManager.shared.searchItems = searchList

        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
}
