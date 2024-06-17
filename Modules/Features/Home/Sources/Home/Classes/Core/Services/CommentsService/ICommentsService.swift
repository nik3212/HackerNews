//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

protocol ICommentsService {
    func loadComment(id: Int) async throws -> Comment
}
