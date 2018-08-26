//
//  AppStyles.swift
//  HackerNews
//
//  Created by Никита Васильев on 25/08/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit

struct Color {
    static let appBackground = UIColor.fromRGB(9, 9, 9)
    static let tableBackground = UIColor.fromRGB(34, 34, 34)
    static let tableCellBackground = UIColor.fromRGB(34, 34, 34)
    static let tableSelectedCellBackground = UIColor.fromRGB(40, 40, 40)
    static let tableSeparator = UIColor.fromRGB(25, 25, 25)
    
    static let titleCell = UIColor.fromRGB(255, 255, 255)
    static let pointsCell = UIColor.fromRGB(255, 255, 255)
    
    static let segmentedControlBackground = UIColor.fromRGB(34, 34, 34)
    static let segmentedControlSelect = UIColor.fromRGB(241, 89, 37)
    static let segmentedControlText = UIColor.fromRGB(241, 89, 37)
}

struct Font {
    static let segmentedControl = UIFont(name: "OpenSans-Bold", size: 12)!
}
