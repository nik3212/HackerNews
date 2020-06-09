//
//  HackerNewsUITests.swift
//  HackerNewsUITests
//
//  Created by Никита Васильев on 24/08/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import XCTest

class HackerNewsUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        App.shared.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testStoriesScreenLoad() {
        waitForExistence(StoriesScreen.navigationBar)
        XCTAssertTrue(StoriesScreen.navigationBar.exists)
    }
}
