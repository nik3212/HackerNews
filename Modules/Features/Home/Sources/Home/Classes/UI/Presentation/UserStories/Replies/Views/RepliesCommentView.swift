//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import SwiftUI

// MARK: - RepliesCommentView

struct RepliesCommentView: View {
    // MARK: Properties

    let viewModel: ViewModel

    // MARK: View

    var body: some View {
        contentView
    }

    // MARK: Private

    private var commentView: some View {
        VStack(alignment: .leading) {
            Text(AttributedString(.html(withBody: viewModel.comment.text)))
        }
    }

    private var verticalLine: some View {
        RoundedRectangle(cornerRadius: 2.0)
            .frame(maxHeight: .infinity)
            .frame(width: 2.0)
            .foregroundStyle(.orange)
    }

    private var contentView: some View {
        VStack(alignment: .leading) {
            CommentHeaderView(viewModel: .init(username: viewModel.comment.username, date: viewModel.comment.date))

            Divider()

            HStack {
                if viewModel.level > 0 {
                    verticalLine
                        .padding(.vertical, 4.0)
                }

                commentView
            }
            .padding(.leading, .spacing * CGFloat(viewModel.level))
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

// MARK: RepliesCommentView.ViewModel

extension RepliesCommentView {
    struct ViewModel: Identifiable, Equatable {
        var id: UUID { comment.id }
        let comment: CommentView.ViewModel
        let level: Int
    }
}

// MARK: - Constants

private extension CGFloat {
    static let cornerRadius = 16.0
    static let spacing = 8.0
}
