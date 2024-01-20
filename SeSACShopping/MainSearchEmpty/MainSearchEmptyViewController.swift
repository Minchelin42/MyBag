//
//  MainSearchEmptyViewController.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/19.
//

import UIKit

class MainSearchEmptyViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var emptyImage: UIImageView!
    @IBOutlet var emptyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroudnColor
        
        searchBar.blackSearchBarStyle()

        emptyImage.image = UIImage(named: "empty")
        
        emptyLabel.text = "최근 검색어가 없어요"
        emptyLabel.font = .boldSystemFont(ofSize: 17)
        emptyLabel.textColor = .textColor

    }

}
