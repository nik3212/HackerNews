//
//  RootPresenterTests.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 06.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

final class RootPresenterSpec: QuickSpec {
    override func spec() {
        let themeManager = MockThemeManager()
        let view = MockRootViewMock()
        let presenter = RootPresenter(view: view, themeManager: themeManager)
        
        describe("Checking view is ready") {
            it("setup view") {
                presenter.viewIsReady()
                expect(view.theme).to(equal(themeManager.theme))
                expect(themeManager.addedObserver === presenter).to(equal(true))
            }
        }
    }
}

// MARK: Mocks
extension RootPresenterSpec {
    final class MockRootViewMock: UISplitViewController, RootViewInput {
        var theme: Theme?
        
        func setupInitialState(theme: Theme) {
            self.theme = theme
        }
        
        func update(theme: Theme) {
            self.theme = theme
        }
    }
}
