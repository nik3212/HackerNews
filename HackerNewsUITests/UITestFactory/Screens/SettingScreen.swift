//
//  SettingScreen.swift
//  HackerNewsUITests
//
//  Created by Никита Васильев on 09.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

struct SettingScreen {
    static let tabBarButton = UITestFactory.app.tabBars.buttons["settingsTabBarItem"]
    static let tableView = UITestFactory.app.tables["settingsTableView"]
    static let themeCell = SettingScreen.tableView.cells.element(matching: .cell, identifier: "sTCV_0_0")
    static let themeImageView = UITestFactory.app.otherElements.containing(.image, identifier: "ThemeIcon").firstMatch
}
