//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Blade
import BladeTCA
import ComposableArchitecture
import SkeletonUI
import SwiftUI

// MARK: - PostListView

struct PostListView: View {
    // MARK: Properties

    @State private var selectedID: ArticleView.ViewModel.ID?

    private let store: StoreOf<PostsViewStore>

    // MARK: Initialization

    init(store: StoreOf<PostsViewStore>) {
        self.store = store
    }

    // MARK: View

    var body: some View {
        PaginatorView(
            store: store.scope(state: \.paginator, action: \.child),
            content: { state, handler in
                ScrollViewReader { reader in
                    SkeletonView(
                        data: state,
                        quantity: .quantity,
                        configuration: .configuration,
                        builder: { article, index in
                            WithViewStore(store, observe: { $0 }) { store in
                                article.map { article in
                                    handler(article)
                                        .id(index)
                                        .onTapGesture { store.send(.selectItem(article)) }
                                }
                            }
                        }, skeletonBuilder: { index in
                            reductedView(index: index)
                        }
                    )
                    .onChange(of: state.isEmpty) { _, _ in
                        withAnimation {
                            reader.scrollTo(Int.zero)
                        }
                    }
                }
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
        scales: [0.5, 1.0, 0.3, 1],
        insets: .init(top: .inset, leading: .zero, bottom: .inset, trailing: .zero),
        gradient: Gradient(stops: [
            .init(color: Color(uiColor: .gray).opacity(0.3), location: 0.8),
            .init(color: Color(uiColor: .gray).opacity(0.5), location: 0.9),
            .init(color: Color(uiColor: .gray).opacity(0.3), location: 1.0),
        ])
    )
}
