//
//  MockThemeManager.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 06.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

@testable import HackerNews

final class MockThemeManager: ThemeManagerProtocol {
    var theme: Theme = .light
    
    var themes: [Theme] = ThemeManager.shared.themes
    
    var addedObserver: ThemeObserver?
    var removedObserver: ThemeObserver?
    
    func addObserver(_ observer: ThemeObserver) {
        addedObserver = observer
    }
    
    func removeObserver(_ observer: ThemeObserver) {
        removedObserver = observer
    }
}
