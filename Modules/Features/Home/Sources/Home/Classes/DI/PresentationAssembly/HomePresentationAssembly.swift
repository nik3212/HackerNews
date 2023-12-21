//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import Foundation

// MARK: - IHomePresentationAssembly

protocol IHomePresentationAssembly {
    var newsAssembly: INewsAssembly { get }
}

// MARK: - HomePresentationAssembly

final class HomePresentationAssembly: IHomePresentationAssembly {
    // MARK: Properties

    private let servicesAssembly: IHomeServicesAssembly

    // MARK: Initialization

    init(servicesAssembly: IHomeServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }

    // MARK: IHomePresentationAssembly

    var newsAssembly: INewsAssembly {
        NewsAssembly(newsService: servicesAssembly.newsService)
    }
}
