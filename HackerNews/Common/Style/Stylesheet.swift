//
//  Stylesheet.swift
//  HackerNews
//
//  Created by Никита Васильев on 05.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

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
            $0.barTintColor = Colors.lightGray
            $0.backgroundColor = Colors.lightGray
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
        
        static let dark: Style<UINavigationBar> = Style.compose(base, black, whiteText, whiteLargeTitleText, noHairline)
        static let light: Style<UINavigationBar> = Style.compose(base, white, blackText, blackLargeTitleText, hairline)
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
        
        static let lightSettingsBaseText = Style.compose(text1, darkGray)
        static let darkSettingsBaseText = Style.compose(text1, white)
    }
    
    enum View {
        static let light: Style<UIView> = Style {
            $0.backgroundColor = Colors.lightGray
        }
        
        static let dark: Style<UIView> = Style {
            $0.backgroundColor = Colors.black
        }
    }
    
    enum Cell {
        static let light: Style<UITableViewCell> = Style {
            $0.selectedBackgroundView?.backgroundColor = .lightGray
            $0.backgroundColor = Colors.white
        }
        
        static let dark: Style<UITableViewCell> = Style {
            $0.selectedBackgroundView?.backgroundColor = .darkGray
            $0.backgroundColor = Colors.darkGray
        }
    }
    
    enum TableView {
        private static let base: Style<UITableView> = Style {
           $0.separatorStyle = .none
        }

        private static let darkBackground: Style<UITableView> = Style {
            $0.backgroundColor = Colors.black
            $0.indicatorStyle = .white
        }
        
        private static let lightBackground: Style<UITableView> = Style {
            $0.backgroundColor = Colors.lightGray
            $0.indicatorStyle = .black
        }
        
        static let light = Style<UITableView>.compose(base, lightBackground)
        static let dark = Style<UITableView>.compose(base, darkBackground)
    }
}
