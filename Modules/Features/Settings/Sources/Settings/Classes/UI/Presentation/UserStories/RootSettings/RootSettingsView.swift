//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import DesignKit
import HackerNewsLocalization
import SwiftUI
import UIExtensions

struct RootSettingsView: View {
    // MARK: Properties

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.presentationMode) private var presentationMode

    let store: StoreOf<RootSettingsFeature>

    // MARK: Initialization

    init(store: StoreOf<RootSettingsFeature>) {
        self.store = store
    }

    // MARK: View

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                contentView(viewStore)
                    .navigationTitle(L10n.Settings.Navbar.title)
                    .toolbar {
                        if horizontalSizeClass != .compact {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(L10n.Common.Actions.cancel) {
                                    presentationMode.wrappedValue.dismiss()
                                }
                                .tint(.orange)
                            }
                        }
                    }
            }
            .listStyle(.insetGrouped)
            .tint(Color(uiColor: .label))
        }
    }

    private var headerView: some View {
        HStack {
            VStack {
                Text("HackerNews")
                    .font(FontFamily.Montserrat.semiBold.font(size: .size17).sui)
                Text("By Nikita Vasilev")
                    .font(FontFamily.Montserrat.semiBold.font(size: .size13).sui)
            }
        }
    }

    private func contentView(_ viewStore: ViewStore<RootSettingsFeature.State, RootSettingsFeature.Action>) -> some View {
        List {
            headerView

            Button(action: {
                viewStore.send(.sendFeedback)
            }) {
                NavigationLink(L10n.Settings.Menu.sendFeedback, destination: EmptyView())
            }
            .sheet(isPresented: viewStore.binding(
                get: \.isEmailSheetPresented,
                send: RootSettingsFeature.Action.setEmailSheetPresented
            )) {
                MailView(isPresented: viewStore.binding(
                    get: \.isEmailSheetPresented,
                    send: RootSettingsFeature.Action.setEmailSheetPresented
                ))
            }

            Button(action: {
                viewStore.send(.rateUs)
            }) {
                NavigationLink(L10n.Settings.Menu.rateUs, destination: EmptyView())
            }

            Button(action: {
                viewStore.send(.openGitHub)
            }) {
                NavigationLink(L10n.Settings.Menu.github, destination: EmptyView())
            }
        }
    }
}
