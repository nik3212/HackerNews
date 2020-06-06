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
        
    }
}

// MARK: Mocks
extension MainTabBarPresenterSpec {
    final class MainTabBarView: UISplitViewController, MainTabBarViewInput {
        func setupInitialState(theme: Theme) {
            
        }
        
        func update(theme: Theme) {
            
        }
    }
}
