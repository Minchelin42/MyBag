//
//  SearchResultViewController.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/19.
//

import UIKit
import Alamofire
import Kingfisher
import RealmSwift

class SearchResultViewController: UIViewController {

    @IBOutlet var resultTopView: UIView!
    @IBOutlet var numberOfResultLabel: UILabel!
    @IBOutlet var sortOptionList: [OptionButton]!
    
    @IBOutlet var resultCollectionView: UICollectionView!

    var searchItem = ""
    
    var start: Int = 1
    
    var list: Result = Result(lastBuildDate: "", total: 0, start: 0, display: 0, items: [])
    
    var nowSortIndex = 0
    let sortOption = ["sim", "date", "asc", "dsc"]
    let buttonTitle = ["정확도","날짜순","가격 낮은 순","가격 높은 순"]
    
    let realm = try! Realm()
    var wishList: Results<WishListTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackgroundColor()
        configureView()
        configureCollectionView()
        setLayout()
        
        wishList = realm.objects(WishListTable.self)
        
        print(realm.configuration.fileURL)
        
        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(leftBarButtonItemClicked))
        button.tintColor = .white
        navigationItem.leftBarButtonItem = button
    }
    
    
    @IBAction func sortOptionButtonTapped(_ sender: UIButton) {
        print(#function)

        sortOptionList[nowSortIndex].configureView(isSelected: false)
        nowSortIndex = sender.tag
        sortOptionList[nowSortIndex].configureView(isSelected: true)

        self.start = 1
        SearchAPIManager.callRequest(query: searchItem, sort: sortOption[nowSortIndex], start: start) { result, error in
            if error == nil {
                guard let result = result else { return }

                if self.start == 1 {
                    self.list = result
                } else {
                    self.list.items.append(contentsOf: result.items)
                }
                
                self.numberOfResultLabel.text = "\(self.list.total.prettyNumber)개의 검색 결과"
                
                self.resultCollectionView.reloadData()
                
                if self.start == 1 && !self.list.items.isEmpty{
                    self.resultCollectionView.scrollToItem(at: [0, 0], at: .bottom, animated: false)
                }

            } else {
                print("에러 발생")
            }
        }
    }
    
    @objc func leftBarButtonItemClicked() {
        print(#function)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SearchAPIManager.callRequest(query: searchItem, sort: sortOption[nowSortIndex], start: start) { result, error in
            if error == nil {
                guard let result = result else { return }

                if self.start == 1 {
                    self.list = result
                } else {
                    self.list.items.append(contentsOf: result.items)
                }
                
                self.numberOfResultLabel.text = "\(self.list.total.prettyNumber)개의 검색 결과"
                
                self.resultCollectionView.reloadData()
                
                if self.start == 1 && !self.list.items.isEmpty{
                    self.resultCollectionView.scrollToItem(at: [0, 0], at: .bottom, animated: false)
                }
            } else {
                print("에러 발생")
            }
        }
    }
    
    func sortOptionButtonDesign() {
        for index in 0...3 {
            sortOptionList[index].setTitle(buttonTitle[index], for: .normal)
            sortOptionList[index].configureView(isSelected: false)
            sortOptionList[index].tag = index
        }
    }

}

extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("Prefetch \(indexPaths)")
        
        if !list.items.isEmpty {
            for indexPath in indexPaths {
                if list.items.count - 3 == indexPath.row && start + list.display < list.total {
                    start += list.display
                    SearchAPIManager.callRequest(query: searchItem, sort: sortOption[nowSortIndex], start: self.start) { result, error in
                        if error == nil { //movie에 데이터가 들어간 것
                            guard let result = result else { return }
                            
                            if self.start == 1 {
                                self.list = result
                            } else {
                                self.list.items.append(contentsOf: result.items)
                            }
                            
                            self.numberOfResultLabel.text = "\(self.list.total.prettyNumber)개의 검색 결과"
                            
                            self.resultCollectionView.reloadData()
                            
                            if self.start == 1 && !self.list.items.isEmpty{
                                self.resultCollectionView.scrollToItem(at: [0, 0], at: .bottom, animated: false)
                            }
                            
                            
                        } else {
                            print("에러 발생")
                        }
                    }
                }
            }
        }
    }
}

extension SearchResultViewController: ViewProtocol {
    func configureView() {
        resultTopView.backgroundColor = .clear
        resultCollectionView.backgroundColor = .clear
        navigationItem.title = "\(searchItem)"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        numberOfResultLabel.text = "\(self.list.total.prettyNumber)개의 검색 결과"
        numberOfResultLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        numberOfResultLabel.textColor = .pointColor
        
        sortOptionButtonDesign()
        sortOptionList[nowSortIndex].configureView(isSelected: true)
    }
}

extension SearchResultViewController {
    func configureCollectionView() {
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        resultCollectionView.prefetchDataSource = self
        
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
        return list.items.count
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

        cell.heartButton.configureView(isSelected: hasLike)

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
            print(UserDefaultManager.shared.likeItems)

            //wishItems 추가하는 부분
            let item: Item = list.items[sender.tag]

            let data = WishListTable(title: item.title, link: item.link, image: item.image, lprice: item.lprice, mallName: item.mallName, productId: item.productId)
            
            
            try! realm.write {
                realm.add(data)
                print("Realm Create")
            }

        } else {
            
            if let index = UserDefaultManager.shared.likeItems.firstIndex(where: { $0 as! String == list.items[sender.tag].productId }) {
                UserDefaultManager.shared.likeItems.remove(at: index)
                
                do {
                    try realm.write {
                        realm.delete(self.wishList[index])
                    }
                } catch {
                    print(error)
                }
                
            }

            print(UserDefaultManager.shared.likeItems)


        }
        
        resultCollectionView.reloadData()

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 
        print("select: \(indexPath.row)")
        let sb = UIStoryboard(name: "SearchDetail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchDetailViewController") as! SearchDetailViewController
        
        vc.urlString = "https://msearch.shopping.naver.com/product/\(list.items[indexPath.row].productId)"
        vc.productId = list.items[indexPath.row].productId
        vc.productItem = list.items[indexPath.row]
        
        var title = list.items[indexPath.row].title.replacingOccurrences(of: "<b>", with: "")
        title = title.replacingOccurrences(of: "</b>", with: "")
        
        vc.productName = title
        navigationController?.pushViewController(vc, animated: true)
    }

    
    
}

