//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Blade

// MARK: - PageLoaderProvider

actor PageLoaderProvider<T: Decodable & Equatable> {
    // MARK: Properties

    /// The service responsible for loading pages of data.
    private let paginatorService: any IOffsetPageLoader<T>

    // MARK: Initialization

    init(paginatorService: any IOffsetPageLoader<T>) {
        self.paginatorService = paginatorService
    }

    // MARK: Private

    /// Loads a specific page of data and updates the internal state.
    private func loadPage(limit: Int, offset: Int) async throws -> Page<T> {
        try await paginatorService.loadPage(request: OffsetPaginationRequest(limit: limit, offset: offset))
    }
}

// MARK: IOffsetPageLoader

extension PageLoaderProvider: IOffsetPageLoader {
    func loadPage(request: OffsetPaginationRequest) async throws -> Page<T> {
        try await loadPage(limit: request.limit, offset: request.offset)
    }
}
