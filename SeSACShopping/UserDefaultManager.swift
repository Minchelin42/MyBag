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
        case newMember
        case profileIndex
        case nickName
        case searchItems
        case likeItems
    }
    
    var newMember: Bool {
        get {
            ud.bool(forKey: UDKey.newMember.rawValue)
        }
        set {
            ud.set(newValue, forKey: UDKey.newMember.rawValue)
        }
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
    
    var searchItems: [Any] {
        get {
            ud.array(forKey: UDKey.searchItems.rawValue) ?? []
        }
        set {
            ud.set(newValue, forKey: UDKey.searchItems.rawValue)
        }
    }
    
    var likeItems: [Any] {
        get {
            ud.array(forKey: UDKey.likeItems.rawValue) ?? []
        }
        set {
            ud.set(newValue, forKey: UDKey.likeItems.rawValue)
        }
    }

}
