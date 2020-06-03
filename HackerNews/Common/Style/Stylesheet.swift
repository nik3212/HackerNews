//
//  Stylesheet.swift
//  HackerNews
//
//  Created by Никита Васильев on 05.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit
import Skeleton

// swiftlint:disable type_body_length
struct Stylesheet {
    enum NavigationBar {
        private static let base: Style<UINavigationBar> = Style {
            $0.isTranslucent = false
            $0.titleTextAttributes = [.font: FontStyle.header3.font]
            $0.tintColor = Colors.lightOrange
            
            if #available (iOS 11.0, *) {
                $0.largeTitleTextAttributes = [.font: FontStyle.header1.font]
            }
        }
        
        private static let white: Style<UINavigationBar> = Style {
            $0.barTintColor = Colors.warmGray
            $0.backgroundColor = Colors.warmGray
        }
        
        private static let whiteText: Style<UINavigationBar> = Style {
            guard var attributes = $0.titleTextAttributes else { return }
            attributes[.foregroundColor] = Colors.lightGray
            $0.titleTextAttributes = attributes
        }
        
        private static let whiteLargeTitleText: Style<UINavigationBar> = Style {
            guard #available(iOS 11.0, *), var attributes = $0.largeTitleTextAttributes else { return }
            attributes[.foregroundColor] = Colors.lightGray
            $0.largeTitleTextAttributes = attributes
        }
        
        private static let lightAppearance: Style<UINavigationBar> = Style {
            guard #available(iOS 13.0, *) else { return }
            let apperance = makeLightAppearance()
            $0.compactAppearance = apperance
            $0.scrollEdgeAppearance = apperance
            $0.standardAppearance = apperance
        }
        
        private static let darkAppearance: Style<UINavigationBar> = Style {
            guard #available(iOS 13.0, *) else { return }
            let apperance = makeDarkAppearance()
            $0.compactAppearance = apperance
            $0.scrollEdgeAppearance = apperance
            $0.standardAppearance = apperance
        }
        
        private static let blackLargeTitleText: Style<UINavigationBar> = Style {
            guard #available(iOS 11.0, *), var attributes = $0.largeTitleTextAttributes else { return }
            attributes[.foregroundColor] = Colors.black
            $0.largeTitleTextAttributes = attributes
        }
                
        private static let blackText: Style<UINavigationBar> = Style {
            guard var attributes = $0.titleTextAttributes else { return }
            attributes[.foregroundColor] = Colors.black
            $0.titleTextAttributes = attributes
        }
        
        private static let black: Style<UINavigationBar> = Style {
            $0.barTintColor = Colors.black
            $0.backgroundColor = Colors.black
        }
        
        private static let noHairline: Style<UINavigationBar> = Style {
            $0.shadowImage = UIImage()
        }
        
        private static let hairline: Style<UINavigationBar> = Style {
            $0.shadowImage = UIImage.imageWithColor(color: Colors.gray20)
        }
        
        @available(iOS 13.0, *)
        private static func makeLightAppearance() -> UINavigationBarAppearance {
            let apperance = UINavigationBarAppearance()
            apperance.backgroundColor = Colors.warmGray
            apperance.titleTextAttributes = [.foregroundColor: Colors.black]
            apperance.largeTitleTextAttributes = [.foregroundColor: Colors.black]
            return apperance
        }
        
        @available(iOS 13.0, *)
        private static func makeDarkAppearance() -> UINavigationBarAppearance {
            let apperance = UINavigationBarAppearance()
            apperance.backgroundColor = Colors.black
            apperance.titleTextAttributes = [.foregroundColor: Colors.lightGray]
            apperance.largeTitleTextAttributes = [.foregroundColor: Colors.lightGray]
            return apperance
        }
        
        static let dark: Style<UINavigationBar> = Style.compose(base, black, whiteText, whiteLargeTitleText, noHairline, darkAppearance)
        static let light: Style<UINavigationBar> = Style.compose(base, white, blackText, blackLargeTitleText, hairline, lightAppearance)
    }

    enum TabBar {
        static let dark: Style<UITabBar> = Style {
            $0.barTintColor = Colors.darkGray
            $0.isTranslucent = false
            $0.tintColor = Colors.darkOrange
            $0.unselectedItemTintColor = Colors.warmGrayLight
        }
        
        static let light: Style<UITabBar> = Style {
            $0.barTintColor = Colors.warmGray
            $0.isTranslucent = false
            $0.tintColor = Colors.lightOrange
            $0.unselectedItemTintColor = Colors.warmGrayLight
        }
        
        static func itemImage(_ value: ImageType) -> Style<UITabBarItem> {
            return Style<UITabBarItem> {
                $0.image = value.resource
                $0.selectedImage = value.resourceWhileSelected
                $0.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: 3, right: 0)
                $0.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
            }
        }
    }
    
    enum SegmentedControl {
        private static var lightText: Style<UISegmentedControl> = Style {
            $0.setTitleTextAttributes([.foregroundColor: Colors.white], for: .normal)
        }
        
        private static var darkText: Style<UISegmentedControl> = Style {
            $0.setTitleTextAttributes([.foregroundColor: Colors.black], for: .normal)
        }
        
        private static var lightTintColor: Style<UISegmentedControl> = Style {
            if #available(iOS 13.0, *) {
                $0.selectedSegmentTintColor = Colors.white
            }
        }
        
        private static var darkTintColor: Style<UISegmentedControl> = Style {
            if #available(iOS 13.0, *) {
                $0.selectedSegmentTintColor = Colors.darkGray
            }
        }
        
        static var light: Style = Style.compose(darkText, lightTintColor)
        static var dark: Style = Style.compose(lightText, darkTintColor)
    }
    
    enum Label {
        private static let header1: Style<UILabel> = Style {
            $0.font = FontStyle.header1.font
        }
        
        private static let header2: Style<UILabel> = Style {
            $0.font = FontStyle.header2.font
        }
        
        private static let header3: Style<UILabel> = Style {
            $0.font = FontStyle.header3.font
        }
        
        private static let text1: Style<UILabel> = Style {
            $0.font = FontStyle.text1.font
        }
        
        private static let white: Style<UILabel> = Style {
            $0.textColor = Colors.white
        }
        
        private static let darkGray: Style<UILabel> = Style {
            $0.textColor = Colors.darkGray
        }
        
        private static let gray: Style<UILabel> = Style {
            $0.textColor = Colors.gray
        }
        
        static let lightSettingsBaseText = Style.compose(text1, darkGray)
        static let darkSettingsBaseText = Style.compose(text1, white)
        static let infoSettingsText = Style.compose(text1, gray)
        static let darkTableViewHeaderText = Style.compose(white)
        static let lightTableViewHeaderText = Style.compose(darkGray)
        static let lightPostTitleText = Style.compose(text1, darkGray)
        static let darkPostTitleText = Style.compose(text1, white)
    }
    
    enum View {
        static let alertLight: Style<UIView> = Style {
            $0.tintColor = Colors.darkOrange
        }
        
        static let alertDark: Style<UIView> = Style {
            $0.tintColor = Colors.lightOrange
        }
        
        static let light: Style<UIView> = Style {
            $0.backgroundColor = Colors.lightGray
        }
        
        static let dark: Style<UIView> = Style {
            $0.backgroundColor = Colors.black
        }
    }
    
    enum ActivityIndicator {
        static let light: Style<UIActivityIndicatorView> = Style {
            $0.color = Colors.darkGray
        }
        
        static let dark: Style<UIActivityIndicatorView> = Style {
            $0.color = Colors.lightGray
        }
    }
    
    enum Skeleton {
        static let light: Style<GradientContainerView> = Style {
            $0.gradientLayer.colors = [Colors.greyish.cgColor,
                                       Colors.warmGrayLight.cgColor,
                                       Colors.greyish.cgColor]
        }
        
        static let dark: Style<GradientContainerView> = Style {
            $0.gradientLayer.colors = [Colors.greyishBrown.cgColor,
                                       Colors.gray.cgColor,
                                       Colors.greyishBrown.cgColor]
        }
    }
    
    enum Cell {
        private static let white: Style<UITableViewCell> = Style {
            $0.selectedBackgroundView?.backgroundColor = .lightGray
            $0.backgroundColor = Colors.white
        }
        
        private static let lightGray: Style<UITableViewCell> = Style {
            $0.selectedBackgroundView?.backgroundColor = .lightGray
            $0.backgroundColor = Colors.lightGray
        }
        
        private static let dark: Style<UITableViewCell> = Style {
            $0.selectedBackgroundView?.backgroundColor = .darkGray
            $0.backgroundColor = Colors.darkGray
        }
        
        private static let black: Style<UITableViewCell> = Style {
            $0.selectedBackgroundView?.backgroundColor = .darkGray
            $0.backgroundColor = Colors.black
        }
        
        private static let lightOrangeTint: Style<UITableViewCell> = Style {
            $0.tintColor = Colors.lightOrange
        }
        
        private static let darkOrangeTint: Style<UITableViewCell> = Style {
            $0.tintColor = Colors.darkOrange
        }
        
        private static let grayTint: Style<UITableViewCell> = Style {
            $0.tintColor = Colors.gray
        }
        
        static let lightWithOrangeTint = Style.compose(white, lightOrangeTint)
        static let darkWithOrangeTint = Style.compose(dark, darkOrangeTint)
        static let lightWithGrayTint = Style.compose(white, grayTint)
        static let darkWithGrayTint = Style.compose(dark, grayTint)
        static let lightPostCell = Style.compose(lightGray, grayTint)
        static let darkPostCell = Style.compose(black, grayTint)
    }
    
    enum TableView {
        private static let base: Style<UITableView> = Style {
           $0.separatorStyle = .singleLine
        }
        
        private static let lightSeparator: Style<UITableView> = Style {
            $0.separatorColor = .lightGray
        }
        
        private static let darkSeparator: Style<UITableView> = Style {
            $0.separatorColor = .darkGray
        }

        private static let darkBackground: Style<UITableView> = Style {
            $0.backgroundColor = Colors.black
            $0.indicatorStyle = .white
        }
        
        private static let lightBackground: Style<UITableView> = Style {
            $0.backgroundColor = Colors.lightGray
            $0.indicatorStyle = .black
        }
        
        static let light = Style<UITableView>.compose(base, lightBackground, lightSeparator)
        static let dark = Style<UITableView>.compose(base, darkBackground, darkSeparator)
    }
    
    enum RefreshControl {
        static let light: Style<UIRefreshControl> = Style {
            $0.tintColor = UIColor.darkGray
        }
        
        static let dark: Style<UIRefreshControl> = Style {
            $0.tintColor = UIColor.lightGray
        }
    }
    
    enum TableViewHeader {
        static let light: Style<UITableViewHeaderFooterView> = Style {
            $0.contentView.backgroundColor = Colors.greyish
        }
        
        static let dark: Style<UITableViewHeaderFooterView> = Style {
            $0.contentView.backgroundColor = Colors.greyishBrown
        }
    }
    
    enum AttributedString {
        static func commentTitle(string: String, color: UIColor) -> NSAttributedString {
            return string.attributedString(textAlignment: .left, textColor: color, font: FontStyle.text3.font)
        }
        
        static func commentText(string: String, color: UIColor) -> NSAttributedString {
            return string.attributedString(withLetterSpacing: 0.2, lineHeight: 8.0,
                                           textAlignment: .left, textColor: color,
                                           font: FontStyle.text2.font)
        }
        
        static func noCommentsText(string: String, color: UIColor) -> NSAttributedString {
            return string.attributedString(withLetterSpacing: 0.2,
                                           textAlignment: .center,
                                           textColor: color,
                                           font: FontStyle.header3.font)
        }
        
        static func postDescription(icon: UIImage, color: UIColor) -> NSAttributedString {
            return NSAttributedString.attributedString(from: icon, color: color)
        }
        
        static func postDescription(string: String, color: UIColor) -> NSAttributedString {
            return string.attributedString(textAlignment: .left, textColor: color, font: FontStyle.text3.font)
        }
        
        static func emptySetTitle(string: String, color: UIColor) -> NSAttributedString {
            return string.attributedString(textAlignment: .center, textColor: color, font: FontStyle.header2.font)
        }
        
        static func emptySetDescription(string: String, color: UIColor) -> NSAttributedString {
            return string.attributedString(textAlignment: .center, textColor: color, font: FontStyle.text3.font)
        }
    }
}
// swiftlint:enable type_body_length
