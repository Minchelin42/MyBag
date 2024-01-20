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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroudnColor

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
    
    // MARK: - 최근 검색 테이블 셀 모두 지우기
    @IBAction func listClearButtonTapped(_ sender: UIButton) {
        print(#function)
    }
    
}

extension MainSearchViewController {
    func configureTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
        
        let xib = UINib(nibName: SearchLogTableViewCell.identifier, bundle: nil)
        listTableView.register(xib, forCellReuseIdentifier: SearchLogTableViewCell.identifier)
        
        listTableView.allowsSelection = false
    }
}

extension MainSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchLogTableViewCell.identifier, for: indexPath) as! SearchLogTableViewCell
        
        // MARK: - 나중에 검색 기록을 담은 배열 index 사용
        cell.searchLogLabel.text = "\(indexPath.row)"
        
        cell.backgroundColor = .backgroudnColor
        cell.deleteButton.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
}
