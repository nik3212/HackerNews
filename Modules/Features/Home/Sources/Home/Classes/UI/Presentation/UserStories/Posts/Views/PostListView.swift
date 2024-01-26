//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import Paginator
import PaginatorTCA
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
        PaginatorView(
            store: store.scope(state: \.paginator, action: { .child($0) }),
            content: { state, handler in
                SkeletonView(
                    data: state,
                    quantity: .quantity,
                    configuration: .configuration,
                    builder: { article, _ in
                        article.map { handler($0) }
                    }, skeletonBuilder: { index in
                        self.reductedView(index: index)
                    }
                )
            },
            rowContent: { item -> ArticleView in
                ArticleView(viewModel: item)
            }
        )
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
        scales: [0.5, 1.0, 0.3, 0.25],
        insets: .init(top: .inset, leading: .zero, bottom: .inset, trailing: .zero)
    )
}
