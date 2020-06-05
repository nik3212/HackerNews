//
//  Utils.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 06.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import XCTest

func assertThrowsKeyNotFound<T: Decodable>(_ expectedKey: String, decoding: T.Type, from data: Data,
                                           file: StaticString = #file, line: UInt = #line) {
    XCTAssertThrowsError(try JSONDecoder().decode(decoding, from: data), file: file, line: line) { error in
        if case .keyNotFound(let key, _)? = error as? DecodingError {
            XCTAssertEqual(expectedKey, key.stringValue, "Expected missing key \(key.stringValue) to equal \(expectedKey).",
                file: file, line: line)
        } else {
            XCTFail("Expected '.keyNotFound(\(expectedKey))' but got \(error)", file: file, line: line)
        }
    }
}
