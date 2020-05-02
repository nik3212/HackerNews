//
//  AskConfiguratorTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

class AskConfiguratorTests: QuickSpec {
    override func spec() {
        let module = AskConfigurator().configure()

        describe("Check module configuration") {
            it("Module input shouldn't be nil") {
                expect(module).notTo(beNil())
                expect(module).to(beAKindOf(AskModuleInput.self))
            }
        }
    }
}
