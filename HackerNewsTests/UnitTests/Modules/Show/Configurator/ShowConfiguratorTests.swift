//
//  ShowConfiguratorTests.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 07.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Quick
import Nimble
import Swinject

@testable import HackerNews

final class ShowConfiguratorTests: QuickSpec {
    override func spec() {
        let parentAssembler = Assembler()
        let viewController = ShowConfigurator(parentAssembler: parentAssembler).configureViewController()

        describe("Check module configuration") {
            it("Module input shouldn't be nil") {
                expect(viewController).notTo(beNil())
                expect(viewController).to(beAKindOf(UINavigationController.self))
                expect((viewController as? UINavigationController)?.topViewController).to(beAKindOf(PostsViewController.self))
            }
        }
    }
}
