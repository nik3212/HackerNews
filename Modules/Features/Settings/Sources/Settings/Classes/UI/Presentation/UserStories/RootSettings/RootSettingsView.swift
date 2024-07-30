//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct RootSettingsView: View {
    // MARK: Properties

    let store: StoreOf<RootSettingsFeature>

    // MARK: Initialization

    init(store: StoreOf<RootSettingsFeature>) {
        self.store = store
    }

    // MARK: View

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                List {
                    Button(action: {
                        viewStore.send(.sendFeedback)
                    }) {
                        Text("Send Feedback")
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
                        Text("Rate Us")
                    }

                    Button(action: {
                        viewStore.send(.openGitHub)
                    }) {
                        Text("GitHub")
                    }
                }
                .navigationTitle("Settings")
            }
        }
    }
}
