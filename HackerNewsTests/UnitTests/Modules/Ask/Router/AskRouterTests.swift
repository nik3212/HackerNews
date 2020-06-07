//
//  AskRouterTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

class AskRouterTests: QuickSpec {
    override func spec() {
        let viewController = UISplitViewController()
        let router = AskRouter()
        router.commentsConfigurator = CommentsConfigurator(parentAssembler: MockContainer().assembler)
        router.transitionHandler = viewController

        describe("Checking presenting modules") {
            it("show comments module") {
                router.openCommentsModule(for: TestData.post)
                let vc = (viewController.viewControllers[0] as? UINavigationController)?.topViewController
                expect(vc).to(beAKindOf(CommentsViewController.self))
            }
        }
    }
}
