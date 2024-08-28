//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

final class PostRequest: BaseRequest {
    // MARK: Properties

    private let id: Int

    // MARK: Initialization

    init(id: Int) {
        self.id = id
    }

    // MARK: BaseRequest

    override var path: String {
        "item/\(id).json"
    }
}
