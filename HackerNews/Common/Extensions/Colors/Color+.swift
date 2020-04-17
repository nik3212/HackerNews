//
//  Colors+.swift
//  HackerNews
//
//  Created by Никита Васильев on 24/08/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit

extension UIColor {
    static func fromRGB(_ r: Int, _ g: Int, _ b: Int) -> UIColor {
        return .fromRGBA(r, g, b, 1.0)
    }
    
    static func fromRGBA(_ r: Int, _ g: Int, _ b: Int, _ a: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0,
                       green: CGFloat(g) / 255.0,
                       blue: CGFloat(b) / 255.0,
                       alpha: a)
    }
}
