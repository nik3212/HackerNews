//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Blade

// MARK: - PageLoaderProvider

actor PageLoaderProvider<T: Decodable & Equatable> {
    // MARK: Types

    /// Enum representing errors that may occur during pagination.
    enum Error: Swift.Error {
        case alreadyLoading
    }

    // MARK: Properties

    /// Internal flag to track whether the paginator is currently loading data.
    private var isLoadingInternal = false

    /// The service responsible for loading pages of data.
    private let paginatorService: any IOffsetPageLoader<T>

    /// Public property to check if the paginator is currently loading.
    private(set) var isLoading: Bool {
        get { Task.isCancelled || isLoadingInternal }
        set { isLoadingInternal = newValue }
    }

    // MARK: Initialization

    init(paginatorService: any IOffsetPageLoader<T>) {
        self.paginatorService = paginatorService
    }

    // MARK: Private

    /// Loads a specific page of data and updates the internal state.
    private func loadPage(limit: Int, offset: Int) async throws -> Page<T> {
        guard !isLoading else { throw Error.alreadyLoading }

        defer { isLoading = false }
        isLoading = true

        return try await paginatorService.loadPage(request: OffsetPaginationRequest(limit: limit, offset: offset))
    }
}

// MARK: IOffsetPageLoader

extension PageLoaderProvider: IOffsetPageLoader {
    func loadPage(request: OffsetPaginationRequest) async throws -> Page<T> {
        try await loadPage(limit: request.limit, offset: request.offset)
    }
}