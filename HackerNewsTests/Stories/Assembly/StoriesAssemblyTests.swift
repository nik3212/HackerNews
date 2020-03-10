//
//  StoriesAssemblyTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble
import Swinject

@testable import HackerNews

class StoriesModuleAssemblyTests: QuickSpec {
    let container = Container()

    override func spec() {
        let assembly = StoriesModuleAssembly()
        assembly.assemble(container: container)

        let viewController = container.resolve(StoriesViewController.self)
        let presenter = viewController?.output as? StoriesPresenter
        let router = presenter?.router as? StoriesRouter
        let interactor = presenter?.interactor as? StoriesInteractor

        describe("Checking module creation") {
            it("Must be StoriesViewController") {
                expect(viewController).toNot(beNil())
                expect(viewController).to(beAKindOf(StoriesViewController.self))
            }
            
            it("Must contains correct output") {
                expect(viewController?.output).toNot(beNil())
                expect(viewController?.output).to(beIdenticalTo(presenter))
            }
            
            it("Must contains view, interactor and router") {
                expect(presenter?.view).toNot(beNil())
                expect(presenter?.view).to(beIdenticalTo(viewController))
                expect(presenter?.router).toNot(beNil())
                expect(presenter?.router).to(beIdenticalTo(router))
                expect(presenter?.interactor).toNot(beNil())
                expect(presenter?.interactor).to(beIdenticalTo(interactor))
            }

            it("Must contains output") {
                expect(interactor?.output).toNot(beNil())
                expect(interactor?.output).to(beIdenticalTo(presenter))
            }

            it("Must contains correct transitionHandler") {
                expect(router?.transitionHandler).toNot(beNil())
                expect(router?.transitionHandler).to(beIdenticalTo(viewController))
            }
        }
    }
}