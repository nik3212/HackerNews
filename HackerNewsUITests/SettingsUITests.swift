//
//  SettingsUITests.swift
//  HackerNewsUITests
//
//  Created by Никита Васильев on 09.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import XCTest

final class SettingsUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        App.shared.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatCellExistence() {
        let settingsButton = SettingScreen.tabBarButton
        settingsButton.tap()
        
        let firstCell = SettingScreen.themeCell
        let existencePredicate = NSPredicate(format: "exists == 1")
        let expectationEval = expectation(for: existencePredicate, evaluatedWith: firstCell, handler: nil)
        let mobWaiter = XCTWaiter.wait(for: [expectationEval], timeout: 10.0)
        XCTAssert(XCTWaiter.Result.completed == mobWaiter, "Test Case Failed.")
    }
    
    func testThatThemeCellSelection() {
        let settingsButton = SettingScreen.tabBarButton
        settingsButton.tap()
        
        let firstCell = SettingScreen.themeCell
        let predicate = NSPredicate(format: "isHittable == true")
        let expectationEval = expectation(for: predicate, evaluatedWith: firstCell, handler: nil)
        let waiter = XCTWaiter.wait(for: [expectationEval], timeout: 10.0)
        XCTAssert(XCTWaiter.Result.completed == waiter, "Test Case Failed.")
        firstCell.tap()
    }
    
    func testThatTitleLabelAndInfoLabelExistanceOnCell() {
        let settingsButton = SettingScreen.tabBarButton
        settingsButton.tap()
        
        let firstCell = SettingScreen.themeCell
        
        XCTAssertTrue(firstCell.exists, "Table view cell not exist.")
        
        let titleLabel = firstCell.staticTexts["titleLabel"]
        XCTAssertTrue(titleLabel.exists, "Title label not exist.")
        
        let infoLabel = firstCell.staticTexts["infoLabel"]
        XCTAssertTrue(infoLabel.exists, "Info label not exist.")
    }
    
    func testThatThemeImageViewExistance() {
        let settingsButton = SettingScreen.tabBarButton
        settingsButton.tap()
        
        let themeImageView = SettingScreen.themeImageView
        XCTAssertTrue(themeImageView.exists, "Image view not exist.")
    }
    
    func testThatThemeChangedToLight() {
        let settingsButton = SettingScreen.tabBarButton
        settingsButton.tap()

        let themeCell = SettingScreen.themeCell
        themeCell.tap()

        let darkCell = ThemesScreen.lightThemeCell
        darkCell.tap()
        
        XCTAssertEqual(themeCell.staticTexts["infoLabel"].label, "Light")
    }
    
    func testThatThemeChangedToDark() {
        let settingsButton = SettingScreen.tabBarButton
        settingsButton.tap()
        
        let themeCell = SettingScreen.themeCell
        themeCell.tap()

        let darkCell = ThemesScreen.darkThemeCell
        darkCell.tap()
        
        XCTAssertEqual(themeCell.staticTexts["infoLabel"].label, "Dark")
    }
}
