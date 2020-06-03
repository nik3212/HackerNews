//
//  CommentsAssemblyTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 24/04/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble
import Swinject

@testable import HackerNews

class CommentsModuleAssemblyTests: QuickSpec {
    let container = Container()

    override func spec() {
        let assembly = CommentsModuleAssembly()
        assembly.assemble(container: container)

        let viewController = container.resolve(CommentsViewController.self)
        let presenter = viewController?.output as? CommentsPresenter
        let router = presenter?.router as? CommentsRouter
        let interactor = presenter?.interactor as? CommentsInteractor

        describe("Checking module creation") {
            it("Must be CommentsViewController") {
                expect(viewController).toNot(beNil())
                expect(viewController).to(beAKindOf(CommentsViewController.self))
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
