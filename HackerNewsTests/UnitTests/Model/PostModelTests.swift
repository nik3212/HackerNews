//
//  PostModelTests.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 05.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation
import XCTest

@testable import HackerNews

final class PostModelTests: XCTestCase {
    func testThatDecodingWhenMissingTypeItThrows() {
        assertThrowsKeyNotFound("id", decoding: PostModel.self, from: TestData.storyWithoutIdJSON.data)
    }
    
    func testThatDecodingWhenPostReturnAPost() throws {
        let post = try JSONDecoder().decode(PostModel.self, from: TestData.storyJSON.data)
        XCTAssertEqual(post.id, 8863, "")
        XCTAssertEqual(post.by, "name", "")
        XCTAssertEqual(post.kids, [ 8952, 9224, 8917, 8884, 8887, 8943, 8869, 8958, 9005, 9671, 8940 ], "")
        XCTAssertEqual(post.score, 111, "")
        XCTAssertEqual(post.time, 1175714200, "")
        XCTAssertEqual(post.title, "My YC app: Dropbox - Throw away your USB drive")
        XCTAssertEqual(post.url, "http://www.getdropbox.com/u/2/screencast.html", "")
    }
}
