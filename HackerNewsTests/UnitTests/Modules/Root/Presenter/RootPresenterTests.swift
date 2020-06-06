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
        
    }
}

// MARK: Mocks
extension RootPresenterSpec {
    final class MockRootView: UISplitViewController, RootViewInput {
        func setupInitialState(theme: Theme) {
            
        }
        
        func update(theme: Theme) {
            
        }
    }
}
