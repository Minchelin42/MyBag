//
//  SearchResultViewController.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/19.
//

import UIKit

class SearchResultViewController: UIViewController {

    @IBOutlet var resultTopView: UIView!
    @IBOutlet var numberOfResultLabel: UILabel!
    @IBOutlet var accuracyButton: UIButton!
    @IBOutlet var dateButton: UIButton!
    @IBOutlet var highPriceButton: UIButton!
    @IBOutlet var lowPriceButton: UIButton!
    
    @IBOutlet var resultCollectionView: UICollectionView!
    
    // MARK: - API 통신으로 받아오기
    var resultNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroudnColor
        
        resultTopView.backgroundColor = .clear
        resultCollectionView.backgroundColor = .clear
        
        numberOfResultLabel.text = "\(resultNum)개의 검색 결과"
        numberOfResultLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        numberOfResultLabel.textColor = .pointColor

        accuracyButton.optionButtonStyle(title: "정확도", isSelected: true)
        dateButton.optionButtonStyle(title: "날짜순", isSelected: false)
        highPriceButton.optionButtonStyle(title: "가격 높은 순", isSelected: false)
        lowPriceButton.optionButtonStyle(title: "가격 낮은 순", isSelected: false)

        configureCollectionView()
        setLayout()
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
        let cellHeight = cellWidth * 1.4
    
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as! ResultCollectionViewCell
        
        cell.backgroundColor = .clear
        
        cell.resultImage.backgroundColor = .pointColor
        
        cell.heartButton.tag = indexPath.row
        
        cell.heartButton.heartButtonStyle(isSelected: cell.heartButton.isSelected)
        
        // MARK: - API로 목록 받아서 바꿔줘야함
        cell.companyLabel.text = "\(indexPath.row)"
        cell.productLabel.text = "\(indexPath.row)"
        cell.priceLabel.text = "\(indexPath.row)"

        return cell
    }

    
    
}
