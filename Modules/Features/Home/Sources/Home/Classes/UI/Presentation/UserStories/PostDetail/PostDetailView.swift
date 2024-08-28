//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Blade
import BladeTCA
import ComposableArchitecture
import HackerNewsLocalization
import SkeletonUI
import SwiftUI

// MARK: - PostDetailView

struct PostDetailView: View {
    // MARK: Properties

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    @State private var isLoading = false

    private let repliesAssembly: IRepliesAssembly

    let store: StoreOf<PostDetailFeature>

    // MARK: Initialization

    init(store: StoreOf<PostDetailFeature>, repliesAssembly: IRepliesAssembly) {
        self.repliesAssembly = repliesAssembly
        self.store = store
    }

    // MARK: View

    var body: some View {
        contentView
            .listStyle(.insetGrouped)
            .listRowSpacing(.inset)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(L10n.PostDetails.NavigationBar.title)
            .navigationDestination(store: store.scope(state: \.$replies, action: \.replies)) { store in
                repliesAssembly.assemble(store: store)
            }
            .refreshable { await refresh() }
            .onAppear { store.send(.refresh) }
    }

    // MARK: Private

    private var contentView: some View {
        WithViewStore(store, observe: { $0 }) { store in
            toolbar(with: store) {
                if store.hasComments {
                    commentsView(with: store)
                } else {
                    emptyView(with: store)
                }
            }
        }
    }

    private func toolbar(
        with store: ViewStore<PostDetailFeature.State, PostDetailFeature.Action>,
        @ViewBuilder content: () -> some View
    ) -> some View {
        content()
            .toolbar {
                if horizontalSizeClass != .compact {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(L10n.Common.Actions.close) {
                            store.send(.close)
                        }
                        .tint(.orange)
                    }
                }
            }
    }

    private func commentsView(with store: ViewStore<PostDetailFeature.State, PostDetailFeature.Action>) -> some View {
        PaginatorView(
            store: self.store.scope(state: \.paginator, action: \.child),
            content: { state, handler in
                SkeletonView(
                    data: state,
                    quantity: .quantity,
                    configuration: .configuration,
                    builder: { comment, index in
                        if index == .zero {
                            articleView(with: store)
                        }

                        comment.map { comment in
                            handler(comment)
                        }
                    },
                    skeletonBuilder: { index in
                        reductedView(index: index)
                    }
                )
            },
            rowContent: { item -> AnyView in
                ShortCommentView(
                    viewModel: item,
                    action: {
                        store.send(.replyButtonTapped(commentID: item.id))
                    }
                )
                .eraseToAnyView()
            }
        )
    }

    private func emptyView(with store: ViewStore<PostDetailFeature.State, PostDetailFeature.Action>) -> some View {
        List {
            articleView(with: store)
        }
    }

    private func articleView(with store: ViewStore<PostDetailFeature.State, PostDetailFeature.Action>) -> some View {
        ArticleView(viewModel: store.viewModel)
            .onTapGesture { store.send(.presentSafariView(store.viewModel.url)) }
            .fullScreenCover(
                isPresented: store.binding(
                    get: \.isSafariViewPresented,
                    send: PostDetailFeature.Action.dismissSafariView
                )
            ) {
                if let url = store.safariURL {
                    SafariView(url: url, onDismiss: {
                        store.send(.dismissSafariView)
                    })
                }
            }
    }

    private func reductedView(index: Int) -> some View {
        VStack {
            if index == 0 {
                HStack {
                    RoundedRectangle(cornerRadius: .cornerRadius)
                    RoundedRectangle(cornerRadius: .cornerRadius)
                }
            } else {
                RoundedRectangle(cornerRadius: .cornerRadius)
            }
        }
    }

    @MainActor
    private func refresh() async {
        defer { isLoading = false }
        isLoading = true
        await store.send(.refresh).finish()
    }
}

// MARK: - Constants

private extension Int {
    static let quantity = 20
    static let numberOfLines = 4
}

private extension CGFloat {
    static let cornerRadius = 8.0
    static let inset = 8.0
}

private extension SkeletonConfiguration {
    static let configuration = SkeletonConfiguration(
        numberOfLines: .numberOfLines,
        scales: [0.25, 1.0, 0.8],
        insets: .init(top: .inset, leading: .zero, bottom: .inset, trailing: .zero),
        gradient: Gradient(stops: [
            .init(color: Color(uiColor: .gray).opacity(0.3), location: 0.8),
            .init(color: Color(uiColor: .gray).opacity(0.5), location: 0.9),
            .init(color: Color(uiColor: .gray).opacity(0.3), location: 1.0),
        ])
    )
}
