//
//  ThemesScreen.swift
//  HackerNewsUITests
//
//  Created by Никита Васильев on 09.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

struct ThemesScreen {
    static let tableView = UITestFactory.app.tables["themesTableView"]
    static let lightThemeCell = ThemesScreen.tableView.cells.element(matching: .cell, identifier: "themeCell_0_0")
    static let darkThemeCell = ThemesScreen.tableView.cells.element(matching: .cell, identifier: "themeCell_0_1")
}
