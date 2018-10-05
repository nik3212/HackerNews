//
//  AppStyles.swift
//  HackerNews
//
//  Created by Никита Васильев on 25/08/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit

struct Color {
    static let appBackground = UIColor.fromRGB(32, 35, 43)
    static let navigationBarBackground = UIColor.fromRGB(43, 46, 57)
    static let navigationControllerText = UIColor.fromRGB(255, 255, 255)
    static let tabBarBackground = UIColor.fromRGB(43, 46, 57)
    static let tableBackground = UIColor.fromRGB(32, 35, 43)
    static let tableCellBackground = UIColor.fromRGB(43, 46, 57)
    static let tableSelectedCellBackground = UIColor.fromRGB(40, 40, 40)
    static let tableSeparator = UIColor.fromRGB(25, 25, 25)
    
    static let commentsViewBackground = UIColor.fromRGB(36, 38, 48)
    
    static let appTint = UIColor.fromRGB(255, 98, 69)
    
    static let titleCell = UIColor.fromRGB(241, 241, 241)
    static let infoCell = UIColor.fromRGB(87, 96, 111)
    static let linkCell = UIColor.fromRGB(87, 96, 111)
}

struct Font {
    static let segmentedControl = UIFont(name: "OpenSans-Bold", size: 12)!
}
