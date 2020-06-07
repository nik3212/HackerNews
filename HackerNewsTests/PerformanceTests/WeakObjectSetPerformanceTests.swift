//
//  WeakObjectSetPerformanceTests.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 06.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import XCTest

@testable import HackerNews

final class WeakObjectSetPerformanceTests: XCTestCase {
    func testPermormanceContainsElement() {
        let set = fillSet(count: 100_000)
        measure { _ = set.contains(56732 as AnyObject) }
    }
}

// MARK: Helpers
extension WeakObjectSetPerformanceTests {
    func fillSet(count: Int) -> WeakObjectSet<AnyObject> {
        let set = WeakObjectSet<AnyObject>()
        
        for i in 0..<count {
            set.append(i as AnyObject)
        }
        
        return set
    }
}
