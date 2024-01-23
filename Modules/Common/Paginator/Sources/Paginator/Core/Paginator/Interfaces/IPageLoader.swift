//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

public protocol IPageLoader<Element> {
    /// The type of elements the paginator is handling, which must conform to `Decodable` & `Equatable`.
    associatedtype Element: Decodable & Equatable

    func loadPage(request: LimitPageRequest) async throws -> Page<Element>
}
