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

    /// The current page number being loaded.
    private var currentPage: Int

    /// The service responsible for loading pages of data.
    private let paginatorService: any IPaginatorService<T>

    /// Internal flag to track whether the paginator is currently loading data.
    private var isLoadingInternal = false

    /// Public property to check if the paginator is currently loading.
    private(set) var isLoading: Bool {
        get { Task.isCancelled || isLoadingInternal }
        set { isLoadingInternal = newValue }
    }

    /// An array to store the loaded elements.
    private(set) var elements: [T] = []

    // MARK: Initialization

    /// Initializes the Paginator with the provided first page number and paginator service.
    public init(firstPage: Int = 0, paginatorService: any IPaginatorService<T>) {
        self.firstPage = firstPage
        self.currentPage = firstPage
        self.paginatorService = paginatorService
    }

    // MARK: Private

    /// Loads a specific page of data and updates the internal state.
    private func loadPage(limit: Int, offset: Int) async throws -> Page<T> {
        guard !isLoading else { throw Error.alreadyLoading }

        defer { isLoading = false }
        isLoading = true

        do {
            let data = try await paginatorService.loadPage(limit, offset: offset)

            currentPage += 1
            elements += data.items

            return data
        } catch {
            throw error
        }
    }
}

// MARK: - IPaginator

extension Paginator: IPaginator {
    public func refresh() async throws -> Page<T> {
        currentPage = firstPage
        return try await loadPage(limit: 20, offset: 20 * currentPage)
    }

    public func loadNextPage() async throws -> Page<T> {
        try await loadPage(limit: 20, offset: 20 * currentPage)
    }

    public func loadPage(request: LimitPageRequest) async throws -> Page<T> {
        try await loadPage(limit: request.limit, offset: request.offset)
    }

    public func reset() async {
        currentPage = firstPage
        elements = []
        isLoading = false
    }
}
