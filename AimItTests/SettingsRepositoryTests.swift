//
//  SettingsRepositoryTests.swift
//  AimItTests
//
//  Created by Buzurg Rakhimzoda on 6.12.2024.
//

import XCTest
@testable import AimIt

final class SettingsRepositoryTests: XCTestCase {
    
    var repository: SettingsRepository!
    
    override func setUp() {
        repository = MockSettingsRepository()
        super.setUp()
    }
    
    override func tearDown() {
        repository = nil
        super.tearDown()
    }
    
    func testGettingValueFromSettings() throws {
        let key = "themeKey"
        let value: Bool = repository.getSetting(forKey: key, defaultValue: true)
        XCTAssertTrue(value)
    }
    
    func testSettingValueToSettings() throws {
        let key = "name"
        let value = "Dante"
        repository.setSetting(value: value, forKey: key)
        let userName = repository.getSetting(forKey: key, defaultValue: "Other name")
        
        XCTAssertEqual(userName, value)
    }
    
    func testRemovingValueFromSettings() throws {
        let key = "name"
        let value = "Dante"
        repository.setSetting(value: value, forKey: key)
        repository.removeSetting(forKey: key)
        let userName = repository.getSetting(forKey: key, defaultValue: "Other name")
        
        XCTAssertEqual(userName, "Other name")
    }
}
