//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

struct ReplyComment {
    var comment: Comment
    var replies: [ReplyComment] = []
}
