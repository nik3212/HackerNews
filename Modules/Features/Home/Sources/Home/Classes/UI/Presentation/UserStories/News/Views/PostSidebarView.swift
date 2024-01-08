//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct PostSidebarView: View {
    // MARK: Properties

    private let store: StoreOf<NewsViewStore>

    // MARK: Initialization

    init(store: StoreOf<NewsViewStore>) {
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

    private func sidebarView(viewStore: ViewStore<NewsViewStore.State, NewsViewStore.Action>) -> some View {
        List(PostType.allCases) { postType in
            Button(action: {
                viewStore.send(.binding(postType))
            }, label: {
                HStack {
                    Image(systemName: postType.systemName)
                    Text(postType.title)
                }
            })
        }
        .listStyle(SidebarListStyle())
        .scrollContentBackground(.hidden)
    }
}
