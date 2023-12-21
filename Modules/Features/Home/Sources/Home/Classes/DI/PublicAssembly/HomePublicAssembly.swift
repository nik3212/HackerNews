//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import HomeInterfaces
import NetworkLayerInterfaces
import SwiftUI
import UIExtensions

public final class HomePublicAssembly: IHomePublicAssembly {
    // MARK: Properties

    private let presentationAssembly: IHomePresentationAssembly
    private let servicesAssembly: IHomeServicesAssembly

    // MARK: Initialization

    public init(requestProcessor: IRequestProcessor) {
        servicesAssembly = HomeServicesAssembly(requestProcessor: requestProcessor)
        presentationAssembly = HomePresentationAssembly(servicesAssembly: servicesAssembly)
    }

    // MARK: IHomePublicAssembly

    public func assemble() -> AnyView {
        presentationAssembly.newsAssembly.assemble().eraseToAnyView()
    }
}
