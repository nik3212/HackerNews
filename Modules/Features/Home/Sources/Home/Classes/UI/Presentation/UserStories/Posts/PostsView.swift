//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import DesignKit
import SwiftUI

// MARK: - PostsView

struct PostsView: View {
    // MARK: Properties

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var isLoading = false

    private let store: StoreOf<PostsViewStore>

    // MARK: Initialization

    init(store: StoreOf<PostsViewStore>) {
        self.store = store
    }

    // MARK: View

    var body: some View {
        VStack {
            if horizontalSizeClass == .compact {
                compactView
            } else {
                splitView
            }
        }
        .onAppear {
            isLoading = true
            store.send(.refresh)
        }
    }

    // MARK: Private

    private var postListView: some View {
        PostListView(store: self.store)
            .scrollDisabled(isLoading)
            .listStyle(.plain)
            .refreshable {
                defer { isLoading = false }
                isLoading = true
                await self.store.send(.refresh).finish()
            }
    }

    private var compactView: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                VStack(spacing: 8.0) {
                    segmentedControlView(viewStore: viewStore)
                    postListView
                }
                .toolbar { self.toolbarView }
            }
        }
    }

    private var splitView: some View {
        NavigationSplitView(
            sidebar: {
                PostSidebarView(store: self.store)
                    .toolbar { self.toolbarView }
            },
            content: {
                postListView
            },
            detail: { Text("DETAIL") }
        )
    }

    private var toolbarView: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            NavigationTitleView()
                .padding(.bottom, 8.0)
        }
    }

    private func segmentedControlView(
        viewStore: ViewStore<PostsViewStore.State, PostsViewStore.Action>
    ) -> some View {
        SegmentControlView(
            segments: PostType.allCases,
            selection: viewStore.binding(
                get: \.selectedItem,
                send: { .binding($0) }
            ),
            content: { segment in
                HStack(alignment: .center, spacing: .spacing) {
                    Image(systemName: segment.systemName)
                    Text(segment.title)
                        .font(FontFamily.Montserrat.semiBold.font(size: .size17).sui)
                }
                .padding(.insets)
                .foregroundColor(segment == viewStore.selectedItem ? Color(uiColor: .white) : Asset.dynamicLightGray.swiftUIColor)
                .background(segment == viewStore.selectedItem ? Color(uiColor: .systemOrange) : Asset.dynamicGray.swiftUIColor)
            },
            background: {
                RoundedRectangle(cornerRadius: .cornerRadius, style: .continuous)
            }
        )
    }
}

// MARK: - Constants

private extension CGFloat {
    static let cornerRadius = 20.0
    static let spacing = 4.0
}

private extension EdgeInsets {
    static let insets = EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
}
