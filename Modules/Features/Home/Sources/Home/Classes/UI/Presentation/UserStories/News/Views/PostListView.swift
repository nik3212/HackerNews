//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import SkeletonUI
import SwiftUI

// MARK: - PostListView

struct PostListView: View {
    // MARK: Properties

    private let store: StoreOf<NewsViewStore>

    // MARK: Initialization

    init(store: StoreOf<NewsViewStore>) {
        self.store = store
    }

    // MARK: View

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            SkeletonView(
                data: viewStore.articles,
                quantity: .quantity,
                configuration: SkeletonConfiguration(
                    numberOfLines: .numberOfLines,
                    scales: [0.5, 1.0, 0.3, 0.25],
                    insets: .init(top: .inset, leading: .zero, bottom: .inset, trailing: .zero)
                ),
                builder: { article in
                    article.map {
                        ArticleView(viewModel: $0)
                    }
                }, skeletonBuilder: { index in
                    self.reductedView(index: index)
                }
            )
        }
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
