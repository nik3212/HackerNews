//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import Dip
import Foundation

// MARK: - IDefinition

public protocol IDefinition {
    func implements<A>(type a: A.Type) -> IDefinition
}

// MARK: - Locator

public final class Locator {
    let container = DependencyContainer()

    public static let shared = Locator()

    public func resolve<T>() -> T {
        do {
            return try container.resolve()
        } catch {
            fatalError("Object with type \(String(describing: T.self)) must be register in the container")
        }
    }

    public func register<T>(
        _ scope: ComponentScope = .shared,
        type: T.Type = T.self,
        tag: DependencyTagConvertible? = nil,
        types _: [Any.Type] = [],
        factory: @escaping (()) throws -> T
    ) {
        container.register(scope, type: type, tag: tag, factory: factory)
    }
}
