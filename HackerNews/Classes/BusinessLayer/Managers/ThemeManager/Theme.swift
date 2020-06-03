//
//  Theme.swift
//  HackerNews
//
//  Created by Никита Васильев on 05.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit
import Skeleton

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
    
    var segmentedControl: Style<UISegmentedControl> {
        switch self {
        case .dark:
            return Stylesheet.SegmentedControl.dark
        case .light:
            return Stylesheet.SegmentedControl.light
        }
    }
    
    var activityIndicator: Style<UIActivityIndicatorView> {
        switch self {
        case .dark:
            return Stylesheet.ActivityIndicator.dark
        case .light:
            return Stylesheet.ActivityIndicator.light
        }
    }
    
    var cellOne: Style<UITableViewCell> {
        switch self {
        case .dark:
            return Stylesheet.Cell.darkWithOrangeTint
        case .light:
            return Stylesheet.Cell.lightWithOrangeTint
        }
    }
    
    var cellTwo: Style<UITableViewCell> {
        switch self {
        case .dark:
            return Stylesheet.Cell.darkWithGrayTint
        case .light:
            return Stylesheet.Cell.lightWithGrayTint
        }
    }
    
    var postCell: Style<UITableViewCell> {
        switch self {
        case .dark:
            return Stylesheet.Cell.darkPostCell
        case .light:
            return Stylesheet.Cell.lightPostCell
        }
    }
    
    var postTitle: Style<UILabel> {
        switch self {
        case .dark:
            return Stylesheet.Label.darkPostTitleText
        case .light:
            return Stylesheet.Label.lightPostTitleText
        }
    }
    
    var refreshControl: Style<UIRefreshControl> {
        switch self {
        case .dark:
            return Stylesheet.RefreshControl.dark
        case .light:
            return Stylesheet.RefreshControl.light
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
    
    var baseTableViewHeaderTitle: Style<UILabel> {
        switch self {
        case .dark:
            return Stylesheet.Label.darkTableViewHeaderText
        case .light:
            return Stylesheet.Label.lightTableViewHeaderText
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
    
    var tableViewHeader: Style<UITableViewHeaderFooterView> {
        switch self {
        case .dark:
            return Stylesheet.TableViewHeader.dark
        case .light:
            return Stylesheet.TableViewHeader.light
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
    
    var skeleton: Style<GradientContainerView> {
        switch self {
        case .dark:
            return Stylesheet.Skeleton.dark
        case .light:
            return Stylesheet.Skeleton.light
        }
    }

    func emptySetTitle(title: String) -> NSAttributedString {
        let color = self == .dark ? Colors.lightGray : Colors.darkGray
        return Stylesheet.AttributedString.emptySetTitle(string: title, color: color)
    }
    
    func emptySetDescription(text: String) -> NSAttributedString {
        let color = self == .dark ? Colors.lightGray : Colors.darkGray
        return Stylesheet.AttributedString.emptySetDescription(string: text, color: color)
    }
    
    func commentTitle(username: String, time: String) -> NSAttributedString {
        let usernameColor = self == .dark ? Colors.lightOrange : Colors.darkOrange
        let timeColor = self == .dark ? Colors.lightGray : Colors.darkGray
        let dotString = Stylesheet.AttributedString.postDescription(string: " • ", color: timeColor)
        
        let attributedUsername = Stylesheet.AttributedString.commentTitle(string: username, color: usernameColor)
        let attributedTime = Stylesheet.AttributedString.commentTitle(string: time, color: timeColor)
        
        return attributedUsername + dotString + attributedTime
    }
    
    func commentText(text: String) -> NSAttributedString {
        let textColor = self == .dark ? Colors.lightGray : Colors.darkGray
        return Stylesheet.AttributedString.commentText(string: text, color: textColor)
    }
    
    func noCommentsText(text: String) -> NSAttributedString {
        let textColor = self == .dark ? Colors.lightGray : Colors.darkGray
        return Stylesheet.AttributedString.noCommentsText(string: text, color: textColor)
    }
    
    func postDescriptionTitle(score: String?, username: String?, time: String?) -> NSAttributedString {
        let baseColor = self == .dark ? Colors.lightGray : Colors.darkGray
        let dotString = Stylesheet.AttributedString.postDescription(string: " • ", color: baseColor)
        
        var results: [NSAttributedString] = []
        
        if let score = score {
            if let icon = R.image.pointsIcon() {
                results.append(Stylesheet.AttributedString.postDescription(icon: icon, color: baseColor))
                results.append(NSAttributedString(string: " "))
            }
            results.append(Stylesheet.AttributedString.postDescription(string: score, color: baseColor))
            results.append(dotString)
        }
        
        if let username = username {
            results.append(Stylesheet.AttributedString.postDescription(string: username, color: baseColor))
            results.append(dotString)
        }
        
        if let time = time {
            results.append(Stylesheet.AttributedString.postDescription(string: time, color: baseColor))
        }

        return results.reduce(NSAttributedString()) { $0 + $1 }
    }
}
// swiftlint:enable file_lenght
