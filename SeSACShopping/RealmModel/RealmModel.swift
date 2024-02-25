//
//  RealmModel.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/02/26.
//

import Foundation
import RealmSwift

final class WishListTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var link: String
    @Persisted var image: String
    @Persisted var lprice: String
    @Persisted var mallName: String
    @Persisted var productId: String
    
    convenience init(title: String, link: String, image: String, lprice: String, mallName: String, productId: String) {
        self.init()
        self.title = title
        self.link = link
        self.image = image
        self.lprice = lprice
        self.mallName = mallName
        self.productId = productId
    }
}

