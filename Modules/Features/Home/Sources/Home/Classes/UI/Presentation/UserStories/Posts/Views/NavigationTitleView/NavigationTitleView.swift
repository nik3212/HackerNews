//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import DesignKit
import SwiftUI

struct NavigationTitleView: View {
    // MARK: Properties

    private let store: StoreOf<NavigationTitleViewStore>

    // MARK: Initialization

    init(store: StoreOf<NavigationTitleViewStore>) {
        self.store = store
    }

    // MARK: View

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading) {
                Text(viewStore.date)
                    .font(FontFamily.Montserrat.semiBold.font(size: .size13).sui)
                Text(viewStore.appName)
                    .font(FontFamily.Montserrat.bold.font(size: .size17).sui)
            }
        }
        .onAppear {
            store.send(.appear)
        }
    }
}
