//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import SwiftUI
import UIExtensions

// MARK: - CommentView

struct CommentView: View {
    // MARK: Properties

    let viewModel: ViewModel

    // MARK: View

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.title)
                .lineLimit(1)
            Text(AttributedString(.html(withBody: viewModel.text)))
        }
    }
}

// MARK: CommentView.ViewModel

extension CommentView {
    struct ViewModel: Equatable, Identifiable {
        let id = UUID()
        let title: String
        let text: String
    }
}
