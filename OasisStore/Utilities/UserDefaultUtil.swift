//
//  UserDefaultUtil.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/17/23.
//

import Foundation


struct UserDefaultsKey: RawRepresentable {
    var rawValue: String
    static let username = UserDefaultsKey(rawValue: "username")
    static let firstName = UserDefaultsKey(rawValue: "firstName")
    static let lastName = UserDefaultsKey(rawValue: "lastName")
}

class UserDefaultUtil {
    
    static let shared = UserDefaultUtil()
    private init() {}
    
    private var userDefault : UserDefaults {
        return UserDefaults.standard
    }
    
    ///  Remove  user defaults key
    ///  ```
    ///  remove key/value associated with key
    ///  ```
    func set(value: Any, for key: UserDefaultsKey) {
        userDefault.setValue(value, forKey: key.rawValue)
    }
    
    ///  Remove  user defaults keey
    ///  ```
    ///  remove key/value associated with key
    ///  ```
    func remove(key: UserDefaultsKey) {
        userDefault.removeObject(forKey: key.rawValue)
    }
    
    ///  Reset all user defaults key
    ///  ```
    ///  return value associated with key
    ///  ```
    func get(key: UserDefaultsKey) -> Any? {
        userDefault.object(forKey: key.rawValue)
    }
    
    ///  Reset all user defaults
    func reset() {
        remove(key: .username)
        remove(key: .firstName)
        remove(key: .lastName)
    }
}
