//
//  CommentsRouterTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 24/04/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble
import SafariServices

@testable import HackerNews

final class CommentsRouterSpec: QuickSpec {
    override func spec() {
        let viewController = ViewControllerMock()
        let router = CommentsRouter()
        router.transitionHandler = viewController

        describe("Checking presenting modules") {
            it("show safari view controller") {
                router.openPost(from: "http://example.com/")
                expect(viewController.presentedController).to(beAnInstanceOf(SFSafariViewController.self))
            }
        }
    }
}

// MARK: Mocks
extension CommentsRouterSpec {
    final class ViewControllerMock: UIViewController {
        var presentedController: UIViewController?
        
        override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
            presentedController = viewControllerToPresent
            if let completion = completion {
                completion()
            }
        }
    }
}
