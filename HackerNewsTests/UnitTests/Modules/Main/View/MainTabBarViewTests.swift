//
//  MainTabBarViewTests.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 06.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

class MainTabBarViewSpec: QuickSpec {
    override func spec() {
        let output = MainTabBarPresenterMock()
        let view = MainTabBarViewController(theme: .light, output: output)

        describe("Checking view configuration") {
            it("view initializes properties") {
                view.viewDidLoad()
                expect(output.viewIsReadyIsCalled).to(equal(true))
                expect(view.theme).to(equal(.light))
            }
        }
    }
}

// MARK: Mocks
extension MainTabBarViewSpec {
    final class MainTabBarPresenterMock: MainTabBarViewOutput {
        var viewIsReadyIsCalled: Bool = false
        
        func viewIsReady() {
            viewIsReadyIsCalled = true
        }
    }
}
