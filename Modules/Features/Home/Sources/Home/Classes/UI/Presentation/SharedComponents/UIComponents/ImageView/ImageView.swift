//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Kingfisher
import SwiftUI

// MARK: - ImageView

struct ImageView: View {
    // MARK: Properties

    private let url: URL

    // MARK: Initialization

    init(url: URL) {
        self.url = url
    }

    // MARK: - View

    var body: some View {
        KFImage.url(url)
            .resizable()
    }
}
