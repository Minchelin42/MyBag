//
//  SearchResultViewController.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/19.
//

import UIKit
import Alamofire
import Kingfisher

//enum Sort: String {
//    case sim = "sim"
//    case date = "date"
//    case lowToHigh = "arc" //오름차순
//    case highToLow = "drc" //내림차순
//}

class SearchResultViewController: UIViewController {

    @IBOutlet var resultTopView: UIView!
    @IBOutlet var numberOfResultLabel: UILabel!
    @IBOutlet var sortOptionList: [UIButton]!
    
    @IBOutlet var resultCollectionView: UICollectionView!
    
    // MARK: - API 통신으로 받아오기
    var searchItem = ""
    
    var list: Result = Result(lastBuildDate: "", total: 0, start: 0, display: 0, items: [])
    
    var nowSortIndex = 0
    let sortOption = ["sim", "date", "asc", "dsc"]
    let buttonTitle = ["정확도","날짜순","가격 낮은 순","가격 높은 순"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroudnColor
        
        resultTopView.backgroundColor = .clear
        resultCollectionView.backgroundColor = .clear
        navigationItem.title = "\(searchItem)"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        numberOfResultLabel.text = "\(self.list.total.prettyNumber)개의 검색 결과"
        numberOfResultLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        numberOfResultLabel.textColor = .pointColor

        sortOptionButtonDesign()
        sortOptionList[nowSortIndex].optionButtonStyle(isSelected: true)

        configureCollectionView()
        setLayout()
        
        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(leftBarButtonItemClicked))
        button.tintColor = .white
        navigationItem.leftBarButtonItem = button
    }
    
    
    @IBAction func sortOptionButtonTapped(_ sender: UIButton) {
        print(#function)
        
        sortOptionList[nowSortIndex].optionButtonStyle(isSelected: false)
        nowSortIndex = sender.tag
        sortOptionList[nowSortIndex].optionButtonStyle(isSelected: true)

        callRequest(search: searchItem, sort: sortOption[nowSortIndex])
        resultCollectionView.reloadData()
    }
    
    @objc func leftBarButtonItemClicked() {
        print(#function)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        callRequest(search: searchItem, sort: sortOption[nowSortIndex])
    }
    
    func sortOptionButtonDesign() {
        for index in 0...3 {
            sortOptionList[index].setTitle(buttonTitle[index], for: .normal)
            sortOptionList[index].optionButtonStyle(isSelected: false)
            sortOptionList[index].tag = index
        }
    }

    func callRequest(search: String, sort: String){
        //한글일 경우 인코딩 처리
        let query = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let display = 30
        
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(search)&display=\(display)&sort=\(sort)"
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret
        ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: Result.self) { response in
            
            switch response.result {
            case .success(let success):
                dump(success)
                self.list = success
                self.numberOfResultLabel.text = "\(self.list.total.prettyNumber)개의 검색 결과"
                self.resultCollectionView.reloadData()
                
            case .failure(let failure):
                print(failure)
            }
            
        }
        
    }
}

extension SearchResultViewController {
    func configureCollectionView() {
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        
        let xib = UINib(nibName: ResultCollectionViewCell.identifier, bundle: nil)
        resultCollectionView.register(xib, forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
    }
    
    func setLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 15
        
        let cellWidth = (UIScreen.main.bounds.width - (spacing * 3)) / 2
        let cellHeight = cellWidth * 1.5
    
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.scrollDirection = .vertical
    
        resultCollectionView.collectionViewLayout = layout
    }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.display
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as! ResultCollectionViewCell
        
        cell.backgroundColor = .clear
        
        cell.resultImage.kf.setImage(with: URL(string: list.items[indexPath.row].image))
        
        cell.heartButton.tag = indexPath.row
        
        let like = UserDefaultManager.shared.likeItems
        
        let hasLike = like.contains { element -> Bool in
            if element as! String == list.items[indexPath.row].productId {
                return true
            } else {
                return false
            }
        }

        cell.heartButton.heartButtonStyle(isSelected: hasLike)

        cell.companyLabel.text = "\(list.items[indexPath.row].mallName)"
        
        var title = list.items[indexPath.row].title.replacingOccurrences(of: "<b>", with: "")
        title = title.replacingOccurrences(of: "</b>", with: "")
        
        cell.productLabel.text = "\(title)"
        
        let price = (Int(list.items[indexPath.row].lprice)?.prettyNumber)!

        cell.priceLabel.text = "\(price) 원"

        cell.heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)

        return cell
    }
    
    @objc func heartButtonTapped(sender: UIButton) {
        print(#function)
        print(sender.tag)
        
        let like = UserDefaultManager.shared.likeItems
        
        let hasLike = like.contains { element -> Bool in
            if element as! String == list.items[sender.tag].productId {
                return true
            } else {
                return false
            }
        }
        
        if !hasLike {
            UserDefaultManager.shared.likeItems.append(list.items[sender.tag].productId)
        } else {
            print(UserDefaultManager.shared.likeItems)
            UserDefaultManager.shared.likeItems.removeAll(where: { $0 as! String == list.items[sender.tag].productId })
            print(UserDefaultManager.shared.likeItems)
        }
        
        resultCollectionView.reloadData()

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 
        let sb = UIStoryboard(name: "SearchDetail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchDetailViewController") as! SearchDetailViewController
        
        vc.urlString = "https://msearch.shopping.naver.com/product/\(list.items[indexPath.row].productId)"
        vc.productId = list.items[indexPath.row].productId
        
        var title = list.items[indexPath.row].title.replacingOccurrences(of: "<b>", with: "")
        title = title.replacingOccurrences(of: "</b>", with: "")
        
        vc.productName = title
        navigationController?.pushViewController(vc, animated: true)
    }

    
    
}

