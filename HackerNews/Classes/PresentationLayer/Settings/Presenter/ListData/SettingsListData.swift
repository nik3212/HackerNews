//
//  SettingsListData.swift
//  HackerNews
//
//  Created by Никита Васильев on 17.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

enum SettingsListSections: Int, CaseIterable {
    case themes
    case help
    
    var title: String {
        switch self {
        case .themes:
            return "settings.themes.header".localized()
        case .help:
            return "settings.help.header".localized()
        }
    }
}

enum SettingsListData: CaseIterable {
    case themes
    case help
    case rate
    
    var title: String {
        switch self {
        case .themes:
            return "settings.themes.title".localized()
        case .help:
            return "settings.help.title".localized()
        case .rate:
            return "settings.help.rate".localized()
        }
    }
    
    var navigable: Bool {
        switch self {
        case .themes:
            return true
        case .help, .rate:
            return false
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .themes:
            return R.image.themeIcon()
        case .help:
            return R.image.help()
        case .rate:
            return nil
        }
    }
}
