//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import DesignKit
import SwiftUI

// MARK: - NewsView

struct NewsView: View {
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
                segmentedControlView(viewStore: viewStore)
                listView
            }
            .onAppear {
                store.send(.fetchNews)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationTitleView()
                    .padding(.bottom, 8)
            }
        }
    }

    // MARK: Private

    private func segmentedControlView(
        viewStore: ViewStore<NewsViewStore.State, NewsViewStore.Action>
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

    private var listView: some View {
        List {
            Text("AAAA")
        }
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
