//
//  MainTabBarAssemblyTests.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 06.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Quick
import Nimble
import Swinject

@testable import HackerNews

class MainTabBarAssemblySpec: QuickSpec {
    override func spec() {
        let container = MockContainer().container
        
        let viewController = container.resolve(MainTabBarViewController.self)
        let presenter = viewController?.output as? MainTabBarPresenter
        
        describe("Checking module creation") {
            it("Must be AskViewController") {
                expect(viewController).toNot(beNil())
                expect(viewController).to(beAKindOf(MainTabBarViewController.self))
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
