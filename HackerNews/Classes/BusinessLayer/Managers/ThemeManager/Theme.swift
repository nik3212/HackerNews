//
//  Theme.swift
//  HackerNews
//
//  Created by Никита Васильев on 05.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

enum Theme: String {
    /// Light theme
    case light = "Light"
    
    /// Dark theme
    case dark = "Dark"
    
    /// <#Description#>
    static let `default` = Theme.dark
    
    /// Create a new Theme instance.
    ///
    /// - Parameter name: A `String` value that contains the theme name.
    init(name: String) {
        self = Theme(rawValue: name) ?? .default
    }
}

// swiftlint:disable file_length
extension Theme {
    var navigationBar: Style<UINavigationBar> {
        switch self {
        case .dark:
            return Stylesheet.NavigationBar.dark
        case .light:
            return Stylesheet.NavigationBar.light
        }
    }
    
    var tabBar: Style<UITabBar> {
        switch self {
        case .dark:
            return Stylesheet.TabBar.dark
        case .light:
            return Stylesheet.TabBar.light
        }
    }
    
    var cell: Style<UITableViewCell> {
        switch self {
        case .dark:
            return Stylesheet.Cell.dark
        case .light:
            return Stylesheet.Cell.light
        }
    }
    
    var baseSettingsTitle: Style<UILabel> {
        switch self {
        case .dark:
            return Stylesheet.Label.darkSettingsBaseText
        case .light:
            return Stylesheet.Label.lightSettingsBaseText
        }
    }
    
    var infoSettingsTitle: Style<UILabel> {
        switch self {
        case .dark:
            return Stylesheet.Label.infoSettingsText
        case .light:
            return Stylesheet.Label.infoSettingsText
        }
    }
    
    var tableView: Style<UITableView> {
        switch self {
        case .dark:
            return Stylesheet.TableView.dark
        case .light:
            return Stylesheet.TableView.light
        }
    }
    
    var view: Style<UIView> {
        switch self {
        case .dark:
            return Stylesheet.View.dark
        case .light:
            return Stylesheet.View.light
        }
    }
    
    var statusBar: UIStatusBarStyle {
        switch self {
        case .dark:
            return .lightContent
        case .light:
            if #available(iOS 13.0, *) {
                return .darkContent
            } else {
                return .default
            }
        }
    }
}
// swiftlint:enable file_lenght
