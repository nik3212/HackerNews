//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation
import SwiftUI

struct LoadingViewModifier: ViewModifier {
    // MARK: Properties

    let isLoading: Bool

    // MARK: ViewModifier

    func body(content: Content) -> some View {
        VStack {
            content

            if isLoading {
                ProgressView().progressViewStyle(.circular)
            }
        }
    }
}
