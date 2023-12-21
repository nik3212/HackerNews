//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

// MARK: - RootTabBarView

struct RootTabBarView: View {
    // MARK: Properties

    private let store: StoreOf<RootTabBarViewStore>
    private let viewFactory: RootTabBarViewFactory

    // MARK: Initialization

    init(store: StoreOf<RootTabBarViewStore>, viewFactory: RootTabBarViewFactory) {
        self.store = store
        self.viewFactory = viewFactory
    }

    // MARK: View

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            TabView(selection: viewStore.binding(send: { .tab($0.tab) })) {
                tabs(in: viewStore)
            }
        }
    }

    // MARK: Private

    @ViewBuilder
    private func tabItemView(_ tab: Tab, @ViewBuilder content: @escaping () -> some View) -> some View {
        NavigationView {
            content()
        }
        .tabItem {
            Label(title: { Text(tab.name) }, icon: { Image(systemName: tab.iconSystemName) })
        }
    }

    private func tabs(in viewStore: ViewStore<RootTabBarViewStore.State, RootTabBarViewStore.Action>) -> some View {
        ForEach(viewStore.tabs) { tab in
            tabItemView(tab) {
                viewFactory.view(for: tab)
            }
        }
    }
}

// MARK: - ContentView_Previews

// #if DEBUG
//
// import Home
//
// struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        RootTabBarView(
//            store: Store(
//                initialState: RootTabBarViewStore.State(tabs: [.home, .search, .settings], tab: .home)
//            ) {
//                RootTabBarViewStore()
//            },
//            viewFactory: RootTabBarViewFactory(homePublicAssembly: HomePublicAssembly(requestProcessor: <#IRequestProcessor#>))
//        )
//    }
// }
//
// #endif
