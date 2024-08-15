//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import HackerNewsLocalization
import SettingsInterfaces
import SwiftUI

// MARK: - PostSidebarView

struct PostSidebarView: View {
    // MARK: Properties

    private let settingsAssembly: ISettingsPublicAssembly
    private let store: StoreOf<PostsViewStore>

    @State private var feedExpanded = true
    @State private var isSettingsPresented = false

    // MARK: Initialization

    init(store: StoreOf<PostsViewStore>, settingsAssembly: ISettingsPublicAssembly) {
        self.store = store
        self.settingsAssembly = settingsAssembly
    }

    // MARK: View

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                sidebarView(viewStore: viewStore)
                settingsButton
            }
            .sheet(isPresented: $isSettingsPresented, content: {
                settingsAssembly.assemble()
            })
        }
    }

    // MARK: Private

    private var settingsButton: some View {
        Button(
            action: {
                isSettingsPresented = true
            }, label: {
                HStack {
                    Image(systemName: .gear)
                    Text(L10n.Sidebar.Items.settings)
                }
            }
        )
        .tint(.orange)
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .controlSize(.small)
    }

    private func sidebarView(viewStore: ViewStore<PostsViewStore.State, PostsViewStore.Action>) -> some View {
        List(
            selection: viewStore.binding(
                get: { $0.selectedItem },
                send: { .binding($0?.id) }
            )
        ) {
            DisclosureGroup(
                isExpanded: $feedExpanded,
                content: {
                    ForEach(PostType.allCases) { postType in
                        Label(postType.title, systemImage: postType.systemName)
                    }
                },
                label: {
                    Text(L10n.Sidebar.Groups.Feeds.title)
                        .font(.headline)
                }
            )
        }
        .listStyle(.sidebar)
        .tint(.orange)
        .scrollContentBackground(.hidden)
    }
}

// MARK: - Constants

private extension String {
    static let gear = "gear"
}
