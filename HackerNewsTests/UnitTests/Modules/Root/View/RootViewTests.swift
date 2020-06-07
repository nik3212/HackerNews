//
//  RootViewTests.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 06.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

class RootViewSpec: QuickSpec {
    override func spec() {
        let view = RootSplitViewController()
        let output = RootViewPresenterMock()
        
        view.output = output
        
        describe("Checking view configuration") {
            it("view initializes properties") {
                view.viewDidLoad()
                expect(output.viewIsReadyIsCalled).to(equal(true))
                expect(view.preferredDisplayMode).to(equal(.allVisible))
                expect(view.delegate).toNot(beNil())
                expect(view.delegate === view).to(equal(true))
                expect(view.preferredStatusBarStyle).to(equal(.default))
            }
        }
    }
}

// MARK: Mocks
extension RootViewSpec {
    final class RootViewPresenterMock: RootViewOutput {
        var viewIsReadyIsCalled: Bool = false
        
        func viewIsReady() {
            viewIsReadyIsCalled = true
        }
    }
}
