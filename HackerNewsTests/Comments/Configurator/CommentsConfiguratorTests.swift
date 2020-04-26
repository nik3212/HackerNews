//
//  CommentsConfiguratorTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 24/04/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

class CommentsConfiguratorTests: QuickSpec {
    override func spec() {
        let module = CommentsConfigurator().configure()

        describe("Check module configuration") {
            it("Module input shouldn't be nil") {
                expect(module).notTo(beNil())
                expect(module).to(beAKindOf(CommentsModuleInput.self))
            }
        }
    }
}
