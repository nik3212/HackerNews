//
//  RootConfiguratorTests.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 06.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Quick
import Nimble
import Swinject

@testable import HackerNews

class RootConfiguratorSpec: QuickSpec {
    override func spec() {
        let parentAssembler = MockContainer().assembler
        let configurator = RootConfigurator(parentAssembler: parentAssembler)
        let window = UIWindow()
        
        configurator.installIntoWindow(window)
        
        describe("Check module configuration") {
            it("rootViewController should be equal to RootSplitViewController") {
                expect(window.rootViewController).notTo(beNil())
                expect(window.rootViewController).to(beAKindOf(RootSplitViewController.self))
            }
        }
    }
}
