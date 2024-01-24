//
//  UserDefaultManager.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/01/20.
//

import Foundation

@propertyWrapper
struct UserDefaultWrapper<T: Codable> {
    private let key: String
    private let defaultValue: T?

    init(key: String, defaultValue: T?) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T? {
        get {
            if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                if let lodedObejct = try? decoder.decode(T.self, from: savedData) {
                    return lodedObejct
                }
            }
            return defaultValue
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                UserDefaults.standard.setValue(encoded, forKey: key)
            }
        }
    }
    
}

class UserDefaultManager {
    
    private init() { }

    @UserDefaultWrapper(key: "wishList", defaultValue: nil)
    static var wishList: [Item]?
    
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
