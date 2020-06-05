//
//  CommentModelTests.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 06.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation
import XCTest

@testable import HackerNews

final class CommentModelTests: XCTestCase {
    func testThatDecodingWhenMissingTypeItThrows() {
        assertThrowsKeyNotFound("id", decoding: PostModel.self, from: TestData.commentWithoutJSON.data)
    }
    
    func testThatDecodingWhenCommentReturnAComment() throws {
        let post = try JSONDecoder().decode(CommentModel.self, from: TestData.commentJSON.data)
        XCTAssertEqual(post.id, 2921983, "")
        XCTAssertEqual(post.by, "norvig", "")
        XCTAssertEqual(post.kids, [ 2922097, 2922429, 2924562, 2922709, 2922573, 2922140, 2922141 ], "")
        XCTAssertEqual(post.time, 1314211127, "")
        XCTAssertEqual(post.text, "Aw shucks, guys ... you make me blush with your compliments.")
    }
}
