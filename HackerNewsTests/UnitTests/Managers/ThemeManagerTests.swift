//
//  ThemeManagerTests.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 06.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

final class ThemeManagerSpec: QuickSpec {
    override func spec() {
        let mockObserver = MockThemeObserver()
        let themeManager = ThemeManager.shared
        
        beforeEach {
            themeManager.theme = .dark
        }
        
        describe("Checking initial configuration") {
            it("Contains all themes") {
                expect(themeManager.themes).to(equal([.light, .dark]))
            }
            
            it("Checking default theme is dark") {
                expect(themeManager.theme).to(equal(.dark))
            }
        }
        
        describe("Checking that theme manager works correct") {
            it("contains observer") {
                themeManager.addObserver(mockObserver)
                expect(themeManager.observers.contains(mockObserver)).to(equal(true))
            }
            
            it("remove observer") {
                themeManager.addObserver(mockObserver)
                themeManager.removeObserver(mockObserver)
                
                expect(themeManager.observers.contains(mockObserver)).to(equal(false))
            }
            
            it("observer get notification about theme was changed") {
                themeManager.addObserver(mockObserver)
                themeManager.theme = .light
                
                expect(mockObserver.theme).to(equal(themeManager.theme))
            }
        }
    }
}

// MARK: Mocks
extension ThemeManagerSpec {
    final class MockThemeObserver: ThemeObserver {
        var theme: Theme?
        
        func themeDidChange(_ theme: Theme) {
            self.theme = theme
        }
    }
}
