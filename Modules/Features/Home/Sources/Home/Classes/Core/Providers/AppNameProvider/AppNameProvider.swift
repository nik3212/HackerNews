//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

// MARK: - AppNameProvider

final class AppNameProvider: IAppNameProvider {
    // MARK: Properties

    private let bundle: Bundle

    // MARK: Initialization

    init(bundle: Bundle) {
        self.bundle = bundle
    }

    // MARK: IAppNameProvider

    var applicationName: String {
        bundle.infoDictionary?[.bundleNameKey] as? String ?? ""
    }
}

// MARK: - Constants

private extension String {
    static let bundleNameKey = "CFBundleName"
}
