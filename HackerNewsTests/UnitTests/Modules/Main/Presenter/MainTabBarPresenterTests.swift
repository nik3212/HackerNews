//
//  MainTabBarPresenterTests.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 06.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

final class MainTabBarPresenterSpec: QuickSpec {
    override func spec() {
        let themeManager = MockThemeManager()
        let view = MainTabBarViewMock()
        let presenter = MainTabBarPresenter()
        
        presenter.view = view
        presenter.themeManager = themeManager
        
        describe("Checking view is ready") {
            it("setup view") {
                presenter.viewIsReady()
                expect(themeManager.addedObserver === presenter).to(equal(true))
            }
        }
    }
}

// MARK: Mocks
extension MainTabBarPresenterSpec {
    final class MainTabBarViewMock: UISplitViewController, MainTabBarViewInput {
        var theme: Theme?
        
        func update(theme: Theme) {
            self.theme = theme
        }
    }
}
