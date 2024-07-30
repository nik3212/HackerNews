//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import DesignKit
import SwiftUI

// MARK: - PostsView

struct PostsView: View {
    // MARK: Properties

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var isLoading = false
    @State private var isPresented = false

    private let store: StoreOf<PostsViewStore>
    private let navigationTitleAssembly: INavigationTitleAssembly
    private let postDetailsAssembly: IPostDetailAssembly

    // MARK: Initialization

    init(
        store: StoreOf<PostsViewStore>,
        navigationTitleAssembly: INavigationTitleAssembly,
        postDetailsAssembly: IPostDetailAssembly
    ) {
        self.store = store
        self.navigationTitleAssembly = navigationTitleAssembly
        self.postDetailsAssembly = postDetailsAssembly
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
            Task {
                await refresh()
            }
        }
    }

    // MARK: Private

    private var postListView: some View {
        PostListView(store: store)
            .scrollDisabled(isLoading)
            .listStyle(.insetGrouped)
            .listRowSpacing(8.0)
            .refreshable {
                await refresh()
            }
    }

    private var compactView: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStack {
                VStack(spacing: 8.0) {
                    segmentedControlView(viewStore: viewStore)
                    postListView
                        .navigationDestination(store: store.scope(state: \.$postDetail, action: \.postDetail)) { store in
                            postDetailsAssembly.assemble(store: store)
                        }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar { toolbarView }
            }
        }
    }

    private var splitView: some View {
        NavigationSplitView(
            sidebar: {
                PostSidebarView(store: store)
                    .toolbar { toolbarView }
            },
            content: {
                WithViewStore(store, observe: { $0 }) { viewStore in
                    postListView
                        .navigationTitle(viewStore.selectedItem.title)
                }
            },
            detail: {
                IfLetStore(store.scope(state: \.$postDetail, action: \.postDetail)) { store in
                    postDetailsAssembly.assemble(store: store)
                }
            }
        )
        .listStyle(.sidebar)
    }

    private var toolbarView: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            navigationTitleAssembly.assemble()
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

    @MainActor
    private func refresh() async {
        defer { isLoading = false }
        isLoading = true
        await store.send(.refresh).finish()
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
