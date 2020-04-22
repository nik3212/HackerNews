//
//  FontStyle.swift
//  HackerNews
//
//  Created by Никита Васильев on 11.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

enum FontStyle: String {
    
    /// Bold 34
    case header1
    
    /// Bold 22
    case header2
    
    /// Semibold 17
    case header3
    
    /// Regular 17
    case text1
    
    /// Regular 13
    case text2
    
    /// Regular 12
    case text3
    
    ///
    var font: UIFont {
        switch self {
        case .header1:
            return .extraBold >>> huge
        case .header2:
            return .extraBold >>> large
        case .header3:
            return .semiBold >>> medium
        case .text1:
            return .regular >>> medium
        case .text2:
            return .regular >>> normalsize
        case .text3:
            return .regular >>> small
        }
    }
    
}
