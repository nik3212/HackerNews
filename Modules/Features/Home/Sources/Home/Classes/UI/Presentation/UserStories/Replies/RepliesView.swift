//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct RepliesView: View {
    // MARK: Properties

    let store: StoreOf<RepliesFeature>

    // MARK: Initialization

    init(store: StoreOf<RepliesFeature>) {
        self.store = store
    }

    // MARK: View

    var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            NavigationStack {
                List(store.replies) { reply in
                    RepliesCommentView(viewModel: reply)
                }
                .listStyle(.plain)
                .navigationTitle("Replies")
                .toolbarTitleDisplayMode(.inline)
            }
            .onAppear {
                store.send(.refresh)
            }
        }
    }
}
