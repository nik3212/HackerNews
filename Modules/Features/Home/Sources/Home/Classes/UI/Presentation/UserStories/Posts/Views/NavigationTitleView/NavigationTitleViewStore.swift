//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import AppUtils
import ComposableArchitecture
import Foundation

struct NavigationTitleViewStore: Reducer {
    // MARK: Types

    struct State: Equatable {
        var date: String
        var appName: String
    }

    enum Action {
        case appear
    }

    // MARK: Properties

    private let appNameProvider: IAppNameProvider
    private let dateFormatter: IDateFormatter

    // MARK: Initialization

    init(appNameProvider: IAppNameProvider, dateFormatter: IDateFormatter) {
        self.appNameProvider = appNameProvider
        self.dateFormatter = dateFormatter
    }

    // MARK: Reducer

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .appear:
            state.date = dateFormatter.string(from: Date())
            state.appName = appNameProvider.applicationName
            return .none
        }
    }
}
