//
//  PostViewerConfiguratorTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 23/04/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

class PostViewerConfiguratorTests: QuickSpec {
    override func spec() {
        let module = PostViewerConfigurator().configure()

        describe("Check module configuration") {
            it("Module input shouldn't be nil") {
                expect(module).notTo(beNil())
                expect(module).to(beAKindOf(PostViewerModuleInput.self))
            }
        }
    }
}
