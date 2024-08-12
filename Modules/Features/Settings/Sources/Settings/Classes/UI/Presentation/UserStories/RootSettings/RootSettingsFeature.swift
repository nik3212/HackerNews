//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import UIKit

// MARK: - RootSettingsFeature

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
                if let url = URL(string: .rateUs) {
                    UIApplication.shared.open(url)
                }
                return .none

            case .openGitHub:
                if let url = URL(string: .githubURL) {
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

// MARK: - Constants

private extension String {
    static let githubURL = "https://github.com/nik3212/HackerNews"
    static let rateUs = "https://apps.apple.com/app/idYOUR_APP_ID?action=write-review"
}
