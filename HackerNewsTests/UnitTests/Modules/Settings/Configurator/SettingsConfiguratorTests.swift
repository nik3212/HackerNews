//
//  SettingsConfiguratorTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 18/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble
import Swinject

@testable import HackerNews

class SettingsConfiguratorTests: QuickSpec {
    // MARK: Tests
    override func spec() {
        let assembler = MockContainer().assembler
        let configurator = SettingsConfigurator(parentAssembler: assembler)
        let navigationController = configurator.configureViewController() as? UINavigationController
        let viewController = navigationController?.viewControllers.first

        describe("Check module configuration") {
            it("Module input shouldn't be nil") {
                expect(viewController).notTo(beNil())
                expect(viewController).to(beAKindOf(SettingsViewController.self))
            }
        }
    }
}
