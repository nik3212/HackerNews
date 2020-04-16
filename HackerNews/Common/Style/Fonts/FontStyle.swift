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
        }
    }
    
}
