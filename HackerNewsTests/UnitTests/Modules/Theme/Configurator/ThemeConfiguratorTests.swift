//
//  ThemeConfiguratorTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 27/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble
import Swinject

@testable import HackerNews

class ThemeConfiguratorTests: QuickSpec {
    override func spec() {
        let assembler = MockContainer().assembler
        let module = ThemeConfigurator(parentAssembler: assembler).configure()

        describe("Check module configuration") {
            it("Module input shouldn't be nil") {
                expect(module).notTo(beNil())
                expect(module).to(beAKindOf(ThemeModuleInput.self))
            }
        }
    }
}
