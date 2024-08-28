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
            CommentHeaderView(viewModel: .init(username: viewModel.username, date: viewModel.date))

            Divider()

            contentView
        }
        .fixedSize(horizontal: false, vertical: true)
    }

    private var contentView: some View {
        VStack(alignment: .leading) {
            Text(AttributedString(.html(withBody: viewModel.text)))
        }
    }
}

// MARK: CommentView.ViewModel

extension CommentView {
    struct ViewModel: Equatable, Identifiable {
        let id = UUID()
        let username: String
        let date: String
        let text: String
    }
}

// MARK: Constants

private extension CGFloat {
    static let headerSpacing = 4.0
    static let headerImageSize = 12.0
}

// MARK: Preview

// #Preview {
//    CommentView(
//        viewModel: CommentView.ViewModel(
//            username: "nsvasilev",
//            date: "22 hours ago",
//            text: "Comment message"
//        )
//    )
// }
