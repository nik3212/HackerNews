//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import SwiftUI

// MARK: - IPostDetailAssembly

protocol IPostDetailAssembly {
    func assemble() -> AnyView
}

// MARK: - PostDetailAssembly

final class PostDetailAssembly: IPostDetailAssembly {
    func assemble() -> AnyView {
        AnyView(EmptyView())
    }
}
