//
//  StoriesConfiguratorTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble
import Swinject

@testable import HackerNews

class StoriesConfiguratorTests: QuickSpec {
    
    // MARK: Private Properties
    private let container = Container(parent: nil)
    
    // MARK: Tests
    override func spec() {
        let assembler = Assembler(container: container)
        let configurator = StoriesConfigurator(parentAssembler: assembler)
        let navigationController = configurator.configureViewController() as? UINavigationController
        let storiesViewController = navigationController?.viewControllers.first

        describe("Check module configuration") {
            it("ViewController shouldn't be nil") {
                expect(storiesViewController).notTo(beNil())
                expect(storiesViewController).to(beAKindOf(PostsViewController.self))
            }
        }
    }
}
