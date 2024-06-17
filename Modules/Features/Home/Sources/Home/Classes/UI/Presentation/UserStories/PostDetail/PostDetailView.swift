//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Blade
import BladeTCA
import ComposableArchitecture
import SwiftUI

struct PostDetailView: View {
    // MARK: Properties

    @State private var isLoading = false

    let store: StoreOf<PostDetailFeature>

    // MARK: View

    var body: some View {
        WithViewStore(store, observe: { $0 }) { _ in
            VStack {
                postDetailView
                commentsView
            }
            .onAppear {
                store.send(.refresh)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // MARK: Private

    private var postDetailView: some View {
        Text("Details")
    }

    private var commentsView: some View {
        PaginatorListView(store: store.scope(state: \.paginator, action: { .child($0) })) { viewModel in
            CommentView(viewModel: viewModel)
        }
        .listStyle(.plain)
    }

    @MainActor
    private func refresh() async {
        defer { isLoading = false }
        isLoading = true
        await store.send(.refresh).finish()
    }
}
