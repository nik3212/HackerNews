//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import Foundation

@Reducer
struct PostDetailFeature {
    struct State: Equatable {
        let postID: String
    }

    enum Action {}

    var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {}
        }
    }
}
