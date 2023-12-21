//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct NewsView: View {
    // MARK: Properties

    private let store: StoreOf<NewsViewStore>

    // MARK: Initialization

    init(store: StoreOf<NewsViewStore>) {
        self.store = store
    }

    // MARK: View

    var body: some View {
        Text("news view")
            .onAppear {
                store.send(.fetchNews)
            }
    }
}
