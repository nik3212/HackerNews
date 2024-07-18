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
            .padding()
            .background(
                RoundedRectangle(cornerRadius: .cornerRadius)
                    .foregroundStyle(Color(uiColor: UIColor.secondarySystemBackground))
            )
    }

    // MARK: Private

    private var contentView: some View {
        HStack {
            if viewModel.level > 0 {
                verticalLine
            }
            CommentView(viewModel: viewModel.comment)
        }
        .padding(.leading, .spacing * CGFloat(viewModel.level))
    }

    private var verticalLine: some View {
        RoundedRectangle(cornerRadius: 2.0)
            .frame(maxHeight: .infinity)
            .frame(width: 2.0)
            .foregroundStyle(.orange)
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
    static let spacing = 16.0
}

//
// #Preview {
//    RepliesCommentView(
//        viewModel: RepliesCommentView.ViewModel(
//            comment: CommentView.ViewModel(title: "Title", text: "Text"),
//            replies: [
//                RepliesCommentView.ViewModel(
//                    comment: CommentView.ViewModel(title: "Title", text: "Text"),
//                    replies: [
//                        RepliesCommentView.ViewModel(
//                            comment: CommentView.ViewModel(title: "Title", text: "Text"),
//                            replies: [
//
//                            ]
//                        )
//                    ]
//                ),
//                RepliesCommentView.ViewModel(
//                    comment: CommentView.ViewModel(title: "Title", text: "Text"),
//                    replies: [
//
//                    ]
//                )
//            ]
//        )
//    )
// }
