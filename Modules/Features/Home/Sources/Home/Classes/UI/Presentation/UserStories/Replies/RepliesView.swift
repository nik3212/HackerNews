//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import BladeTCA
import ComposableArchitecture
import HackerNewsLocalization
import SkeletonUI
import SwiftUI

// MARK: - RepliesView

struct RepliesView: View {
    // MARK: Properties

    let store: StoreOf<RepliesFeature>

    // MARK: Initialization

    init(store: StoreOf<RepliesFeature>) {
        self.store = store
    }

    // MARK: View

    var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            NavigationStack {
                contentView(with: store)
                    .listStyle(.insetGrouped)
                    .listRowSpacing(.listRowSpacing)
                    .navigationTitle(L10n.Replies.NavigationBar.title)
                    .toolbarTitleDisplayMode(.inline)
            }
            .onAppear {
                store.send(.refresh)
            }
        }
    }

    // MARK: Private

    private func contentView(with store: ViewStore<RepliesFeature.State, RepliesFeature.Action>) -> some View {
        SkeletonView(
            data: store.replies,
            quantity: .quantity,
            configuration: .configuration,
            builder: { reply, _ in
                reply.map { reply in
                    RepliesCommentView(viewModel: reply)
                }
            },
            skeletonBuilder: { index in
                reductedView(index: index)
            }
        )
    }

    private func reductedView(index: Int) -> some View {
        VStack {
            if index == .zero {
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
    static let listRowSpacing = 8.0
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
