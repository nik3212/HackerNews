//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import Foundation

final class PostIdentifiersRequest: BaseRequest {
    // MARK: Properties

    private let postType: PostType

    // MARK: Initialization

    init(postType: PostType) {
        self.postType = postType
    }

    // MARK: IRequest

    override var path: String {
        switch postType {
        case .new:
            return "newstories.json"
        case .best:
            return "beststories.json"
        case .top:
            return "topstories.json"
        case .ask:
            return "askstories.json"
        case .show:
            return "showstories.json"
        }
    }
}
