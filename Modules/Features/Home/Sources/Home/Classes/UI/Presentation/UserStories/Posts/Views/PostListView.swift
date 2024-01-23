//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import Paginator
import SkeletonUI
import SwiftUI

// MARK: - PostListView

struct PostListView: View {
    // MARK: Properties

    private let store: StoreOf<PostsViewStore>

    // MARK: Initialization

    init(store: StoreOf<PostsViewStore>) {
        self.store = store
    }

    // MARK: View

    var body: some View {
        PaginatorListView(store: store.scope(state: \.paginator, action: { .child($0) })) { viewModel in
            ArticleView(viewModel: viewModel)
        }

//        WithViewStore(self.store, observe: { $0 }) { viewStore in
//            SkeletonView(
//                data: viewStore.articles,
//                quantity: .quantity,
//                configuration: SkeletonConfiguration(
//                    numberOfLines: .numberOfLines,
//                    scales: [0.5, 1.0, 0.3, 0.25],
//                    insets: .init(top: .inset, leading: .zero, bottom: .inset, trailing: .zero)
//                ),
//                builder: { article, index in
//                    article.map {
//                        ArticleView(viewModel: $0)
//                            .onAppear {
//                                viewStore.send(.appearItem(index: index))
//                            }
//                    }
//                }, skeletonBuilder: { index in
//                    self.reductedView(index: index)
//                }
//            )
//            if viewStore.isLoading {
//                progressView
//            }
//        }
    }

    // MARK: Private

    private func reductedView(index: Int) -> some View {
        VStack {
            if index == 3 {
                HStack {
                    RoundedRectangle(cornerRadius: .cornerRadius)
                    RoundedRectangle(cornerRadius: .cornerRadius)
                }
            } else {
                RoundedRectangle(cornerRadius: .cornerRadius)
            }
        }
    }

    private var progressView: some View {
        ProgressView()
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
