//
//  Colors.swift
//  HackerNews
//
//  Created by Никита Васильев on 11.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

enum Colors {
    static let white: UIColor = {
        return .fromRGB(255, 255, 255)
    }()
    
    static let black: UIColor = {
        return .fromRGB(0, 0, 0)
    }()
    
    static let darkGray: UIColor = {
        return .fromRGB(43, 43, 43)
    }()
    
    static let gray: UIColor = {
        return .fromRGB(112, 112, 112)
    }()
    
    static let lightGray: UIColor = {
        return .fromRGB(242, 242, 247)
    }()
    
    static let warmGrayLight: UIColor = {
        return .fromRGB(153, 153, 153)
    }()
    
    static let warmGray: UIColor = {
        return .fromRGB(248, 248, 248)
    }()
    
    static let lightOrange: UIColor = {
        return .fromRGB(255, 149, 0)
    }()
    
    static let darkOrange: UIColor = {
        return .fromRGB(255, 159, 10)
    }()
    
    static let gray20: UIColor = {
        return .fromRGBA(199, 201, 209, 0.2)
    }()
}
