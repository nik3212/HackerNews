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

    // MARK: Intiialization

    init(url: URL) {
        self.url = url
    }

    // MARK: - View

    var body: some View {
        KFImage.url(url)
    }
}

#if DEBUG
    struct SwiftUIView_Previews: PreviewProvider {
        static var previews: some View {
            URL(string: "https://en.wikipedia.org/wiki/File:Google_Images_2015_logo.svg").map {
                ImageView(url: $0)
            }
        }
    }
#endif
