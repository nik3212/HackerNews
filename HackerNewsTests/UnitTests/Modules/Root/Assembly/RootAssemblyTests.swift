//
//  RootAssemblyTests.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 06.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Quick
import Nimble
import Swinject

@testable import HackerNews

class RootAssemblySpec: QuickSpec {
    override func spec() {
        let container = MockContainer().container
        
        let mainTabBarViewController = MainTabBarConfigurator(parentAssembler: MockContainer().assembler).configure()
        let viewController = container.resolve(RootSplitViewController.self, argument: mainTabBarViewController)
        let presenter = viewController?.output as? RootPresenter
        
        describe("Checking module creation") {
            it("Must be AskViewController") {
                expect(viewController).toNot(beNil())
                expect(viewController).to(beAKindOf(RootSplitViewController.self))
            }
            
            it("Must contains correct output") {
                expect(viewController?.output).toNot(beNil())
                expect(viewController?.output).to(beIdenticalTo(presenter))
            }
            
            it("Must contains view and theme manager") {
                expect(presenter?.view).toNot(beNil())
                expect(presenter?.view).to(beIdenticalTo(viewController))
                expect(presenter?.themeManager).toNot(beNil())
                expect(presenter?.themeManager).to(beAKindOf(ThemeManager.self))
            }
        }
    }
}
