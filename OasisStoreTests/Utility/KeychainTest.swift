//
//  KeychainTest.swift
//  OasisStoreTests
//
//  Created by Vanara Leng on 6/26/23.
//

import Foundation
import XCTest
@testable import OasisStore


extension KeychainServiceType {
    static let test = KeychainServiceType(rawValue: "test")
}

class KeychainUtilTest: XCTestCase {

    override func tearDown() {
        KeychainUtil.shared.save(service: .test, secret: "")
        super.tearDown()
    }
    
    func test_KeychainUtil_save() {
        // When
        KeychainUtil.shared.save(service: .test, secret: "value")
        
        // Then
        let value = KeychainUtil.shared.retrieve(service: .test)
        XCTAssertEqual(value, "value" )
    }
}
