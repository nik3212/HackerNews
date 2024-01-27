//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct PostSidebarView: View {
    // MARK: Properties

    private let store: StoreOf<PostsViewStore>

    // MARK: Initialization

    init(store: StoreOf<PostsViewStore>) {
        self.store = store
    }

    // MARK: View

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                self.sidebarView(viewStore: viewStore)
            }
        }
    }

    // MARK: Private

    private func sidebarView(viewStore: ViewStore<PostsViewStore.State, PostsViewStore.Action>) -> some View {
        NavigationStack {
            List(
                selection: viewStore.binding(
                    get: { $0.selectedItem },
                    send: { .binding($0?.id ?? .top) }
                )
            ) {
                ForEach(PostType.allCases) { postType in
                    Label(postType.title, systemImage: postType.systemName)
                }
            }
        }
        .listStyle(.sidebar)
        .scrollContentBackground(.hidden)
    }
}
