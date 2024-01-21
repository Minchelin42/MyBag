//
//  Result.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/21.
//

import Foundation

struct Result: Codable {
    let lastBuildDate: String
    let total, start, display: Int
    var items: [Item]
}

struct Item: Codable {
    let title: String
    let link: String
    let image: String
    let lprice, mallName, productId: String
}
