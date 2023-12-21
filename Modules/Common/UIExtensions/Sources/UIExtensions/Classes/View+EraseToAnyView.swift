//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import SwiftUI

public extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
