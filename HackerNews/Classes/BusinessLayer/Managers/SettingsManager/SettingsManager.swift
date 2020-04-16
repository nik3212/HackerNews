//
//  SettingsManager.swift
//  HackerNews
//
//  Created by Никита Васильев on 28.03.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

final class SettingsManager {
    
    // MARK: Public Propreties
    
    /// <#Description#>
    static let shared = SettingsManager()

    // MARK: Initialization
    private init() { }
    
    // MARK: Public Properties
    
    /// A `String` value that contains the current theme name.
    var currentTheme: String? {
        set { UserDefaults.standard.set(newValue, forKey: Constants.Settings.theme) }
        get { UserDefaults.standard.string(forKey: Constants.Settings.theme) }
    }
}
