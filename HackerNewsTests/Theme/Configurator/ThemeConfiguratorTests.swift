//
//  ThemeConfiguratorTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 27/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

class ThemeConfiguratorTests: QuickSpec {
    override func spec() {
        let module = ThemeConfigurator().configure()

        describe("Check module configuration") {
            it("Module input shouldn't be nil") {
                expect(module).notTo(beNil())
                expect(module).to(beAKindOf(ThemeModuleInput.self))
            }
        }
    }
}
