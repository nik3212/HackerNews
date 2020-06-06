//
//  AskConfiguratorTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble
import Swinject

@testable import HackerNews

class AskConfiguratorTests: QuickSpec {
    override func spec() {
        let parentAssembler = Assembler()
        let module = AskConfigurator(parentAssembler: parentAssembler).configureViewController()

        describe("Check module configuration") {
            it("Module input shouldn't be nil") {
                expect(module).notTo(beNil())
                expect(module).to(beAKindOf(UINavigationController.self))
            }
        }
    }
}
