//
//  MainTabBarConfuguratorTests.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 06.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Quick
import Nimble
import Swinject

@testable import HackerNews

final class MainTabBarConfuguratorSpec: QuickSpec {
    override func spec() {
        let parentAssembler = MockContainer().assembler
        let viewController = MainTabBarConfigurator(parentAssembler: parentAssembler).configure()

        describe("Check module configuration") {
            it("rootViewController should be equal to MainTabBarViewController") {
                expect(viewController).notTo(beNil())
                expect(viewController).to(beAKindOf(MainTabBarViewController.self))
            }
        }
    }
}
