//
//  KeychainUtil.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/16/23.
//

import Foundation
import Security

struct KeychainServiceType: RawRepresentable {
    var rawValue: String
    static let accessToken = KeychainServiceType(rawValue: "accessToken")
    static let refreshToken = KeychainServiceType(rawValue: "refreshToken")
}

class KeychainUtil {
    let account = Bundle.main.bundleIdentifier ?? "myapp"
    
    static let shared = KeychainUtil()
    private init() {}
    
    /// Save secret to Keychain
    /// ```
    /// service is type of you retrieve.
    /// secret is your password or token
    /// ```
    func save(service: KeychainServiceType, secret: String) {
        guard let passData = secret.data(using: .utf8) else { return }
        let addQuery : [CFString : Any] = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service.rawValue,
            kSecValueData : passData
        ]
        
        let status = SecItemAdd(addQuery as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            // Update existing item
            let attributesToUpdate = [kSecValueData: passData] as CFDictionary
            SecItemUpdate(addQuery as CFDictionary, attributesToUpdate)
        } else if status != errSecSuccess {
            print(status)
        }
    }

    /// Get secret from keychain
    /// ```
    /// service is type of you secret
    /// ```
    func retrieve(service: KeychainServiceType) -> String? {
        
        let keychainItem: [CFString : Any] = [
          kSecAttrAccount: account,
          kSecAttrService: service.rawValue,
          kSecClass: kSecClassGenericPassword,
          kSecReturnData: true
        ]
        
        var item: AnyObject?
        let status = SecItemCopyMatching(keychainItem as CFDictionary, &item)
        guard status == errSecSuccess else {
            print(status)
            return nil
        }
        
        if let result = item as? Data {
            return String(data: result, encoding: .utf8)
        }
        return nil
    }
    
    
    
    
}
