//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import Foundation

final class NewsRequest: BaseRequest {
    // MARK: Properties

    private let id: Int

    // MARK: Initialization

    init(id: Int) {
        self.id = id
    }

    // MARK: IRequest

    override var path: String {
        ""
    }
}
