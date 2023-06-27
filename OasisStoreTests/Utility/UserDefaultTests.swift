//
//  UserDefaultTests.swift
//  OasisStoreTests
//
//  Created by Vanara Leng on 6/26/23.
//

import XCTest
@testable import OasisStore

extension UserDefaultsKey {
    static let test = UserDefaultsKey(rawValue: "test")
}


final class UserDefaultTests: XCTestCase {


    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_UserDefault_save() {
        // When
        UserDefaultUtil.shared.set(value: "value", for: .test)
        
        // Then
        let value = UserDefaultUtil.shared.get(key: .test) as? String
        XCTAssertEqual(value, "value" )
    }
    
}
