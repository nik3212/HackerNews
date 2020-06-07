//
//  StoriesRouterTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

class StoriesRouterSpec: QuickSpec {
    override func spec() {
        let viewController = UISplitViewController()
        let router = StoriesRouter()
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
