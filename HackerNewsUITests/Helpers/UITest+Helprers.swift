//
//  UITest+Helprers.swift
//  HackerNewsUITests
//
//  Created by Никита Васильев on 09.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import XCTest

private let timeout: TimeInterval = 10.0

func waitForExistence(_ element: XCUIElement, file: StaticString = #file, line: UInt = #line) {
    if !element.waitForExistence(timeout: timeout) {
        XCTFail("Timed out waiting for element: \(element) to appear", file: file, line: line)
    }
}
