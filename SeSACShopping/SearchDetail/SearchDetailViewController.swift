//
//  SearchDetailViewController.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/19.
//

import UIKit
import WebKit

class SearchDetailViewController: UIViewController {

    @IBOutlet var resultView: WKWebView!
    
    let urlString = "http://www.naver.com"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: urlString) {
            
            let request = URLRequest(url: url)
            
            resultView.load(request)
        }

    }

}
