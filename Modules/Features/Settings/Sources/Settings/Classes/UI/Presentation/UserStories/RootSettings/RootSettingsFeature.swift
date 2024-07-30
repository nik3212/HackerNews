//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import UIKit

@Reducer
struct RootSettingsFeature {
    struct State: Equatable {
        var isEmailSheetPresented: Bool = false
    }

    enum Action: Equatable {
        case sendFeedback
        case rateUs
        case openGitHub
        case setEmailSheetPresented(Bool)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .sendFeedback:
                state.isEmailSheetPresented = true
                return .none

            case .rateUs:
                if let url = URL(string: "https://apps.apple.com/app/idYOUR_APP_ID?action=write-review") {
                    UIApplication.shared.open(url)
                }
                return .none

            case .openGitHub:
                if let url = URL(string: "https://github.com/YOUR_GITHUB_REPOSITORY") {
                    UIApplication.shared.open(url)
                }
                return .none

            case let .setEmailSheetPresented(isPresented):
                state.isEmailSheetPresented = isPresented
                return .none
            }
        }
    }
}
