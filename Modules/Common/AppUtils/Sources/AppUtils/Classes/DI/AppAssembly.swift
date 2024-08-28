//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import Dip
import Foundation

open class AppAssembly {
    // MARK: Properties

    private static let container = Locator.shared

    // MARK: Initialization

    public init() {
        Dip.logLevel = .None
    }

    // MARK: Methods

    public func resolve<T>(
        _ type: T.Type = T.self,
        scope: ComponentScope = .shared,
        tag: DependencyTagConvertible? = nil,
        factory: @escaping () -> T
    ) -> T {
        if let object = try? Locator.shared.container.resolve(type, tag: tag) as? T { return object }

        Locator.shared.container.register(scope, type: type, tag: tag) { _ in factory() }

        return resolve(tag: tag)
    }

    // MARK: Private

    private func resolve<T>(tag: DependencyTagConvertible?) -> T {
        do {
            return try Locator.shared.container.resolve(tag: tag) as T
        } catch {
            fatalError("[AppAssembly] The instance with type \(String(describing: T.self)) wasn't found in the container.")
        }
    }
}
