//
//  UserDefaultManager.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/20.
//

import Foundation

class UserDefaultManager {
    
    private init() { }
    
    static let shared = UserDefaultManager()

    let ud = UserDefaults.standard
    
    enum UDKey: String {
        case profileIndex
        case nickName
    }
    
    var profileIndex: Int {
        get {
            ud.integer(forKey: UDKey.profileIndex.rawValue)
        }
        set {
            ud.set(newValue, forKey: UDKey.profileIndex.rawValue)
        }
    }
    
    var nickName: String {
        get {
            ud.string(forKey: UDKey.nickName.rawValue) ?? ""
        }
        set {
            ud.set(newValue, forKey:  UDKey.nickName.rawValue)
        }
    }
    
    
    
}
