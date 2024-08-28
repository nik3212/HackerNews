//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import Foundation
import OrderedCollections

struct RootTabBarViewStore: Reducer {
    struct State: Equatable, Hashable {
        @BindingState var tabs: OrderedSet<Tab>
        @BindingState var tab: Tab
    }

    enum Action {
        case tab(Tab)
    }

    var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {
            case .tab:
                return .none
            }
        }
    }
}
