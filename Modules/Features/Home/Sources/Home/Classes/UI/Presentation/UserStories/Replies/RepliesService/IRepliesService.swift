//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Blade
import Foundation

protocol IRepliesService {
    func loadComments(for commentID: Int) async throws -> ReplyComment
}
