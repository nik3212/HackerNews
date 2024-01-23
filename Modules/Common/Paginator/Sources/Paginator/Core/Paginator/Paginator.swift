//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

/// Paginator is an actor responsible for paginating and loading data using a provided paginator service.
public actor Paginator<T: Decodable & Equatable> {
    // MARK: Types

    /// Enum representing errors that may occur during pagination.
    public enum Error: Swift.Error {
        case alreadyLoading
    }

    // MARK: Properties

    /// The page number of the first page in the pagination sequence.
    private let firstPage: Int

    /// <#Description#>
    private let limit: Int

    /// The current page number being loaded.
    private var currentPage: Int

    /// Internal flag to track whether the paginator is currently loading data.
    private var isLoadingInternal = false

    /// Public property to check if the paginator is currently loading.
    private(set) var isLoading: Bool {
        get { Task.isCancelled || isLoadingInternal }
        set { isLoadingInternal = newValue }
    }

    private let pageLoader: any IPageLoader<T>

    /// An array to store the loaded elements.
    private(set) var elements: [T] = []

    // MARK: Initialization

    /// Initializes the Paginator with the provided first page number and paginator service.
    public init(firstPage: Int = .zero, limit: Int = 20, pageLoader: any IPageLoader<T>) {
        self.firstPage = firstPage
        self.currentPage = firstPage
        self.limit = limit
        self.pageLoader = pageLoader
    }
}

// MARK: - IPaginator

extension Paginator: IPaginator {
    public func refresh() async throws -> Page<T> {
        currentPage = firstPage
        let page = try await pageLoader.loadPage(
            request: LimitPageRequest(limit: limit, offset: limit * currentPage)
        )
        currentPage += 1
        return page
    }

    public func loadNextPage() async throws -> Page<T> {
        let page = try await pageLoader.loadPage(
            request: LimitPageRequest(limit: limit, offset: limit * (currentPage + 1))
        )
        currentPage += 1
        return page
    }

    public func reset() async {
        currentPage = firstPage
        elements = []
        isLoading = false
    }
}
