//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

actor Paginator<T: Decodable> {
    // MARK: Types

    enum Error: Swift.Error {
        case alreadyLoading
    }

    // MARK: Properties

    private let firstPage: Int
    private var currentPage: Int
    private let paginatorService: any IPaginatorService<T>
    private var isLoadingInternal = false

    private(set) var elements: [T] = []
    private(set) var isLoading: Bool {
        get { Task.isCancelled || isLoadingInternal }
        set { isLoadingInternal = newValue }
    }

    // MARK: Initialization

    init(firstPage: Int = 0, paginatorService: any IPaginatorService<T>) {
        self.firstPage = firstPage
        self.currentPage = firstPage
        self.paginatorService = paginatorService
    }

    // MARK: Private

    private func loadPage(_ page: Int) async throws -> PageInfo<T> {
        guard !isLoading else { throw Error.alreadyLoading }

        defer { isLoading = false }
        isLoading = true

        do {
            let data = try await paginatorService.loadPage(page)
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
    func refresh() async throws -> PageInfo<T> {
        currentPage = firstPage
        return try await loadPage(currentPage)
    }

    func loadNextPage() async throws -> PageInfo<T> {
        try await loadPage(currentPage + 1)
    }

    func reset() async {
        currentPage = firstPage
        elements = []
        isLoading = false
    }
}
