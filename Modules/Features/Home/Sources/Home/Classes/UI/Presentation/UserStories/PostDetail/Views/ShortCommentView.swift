//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import SwiftUI

// MARK: - ShortCommentView

struct ShortCommentView: View {
    // MARK: Properties

    private let viewModel: ViewModel
    private let action: () -> Void

    // MARK: Initialization

    init(viewModel: ViewModel, action: @escaping () -> Void) {
        self.viewModel = viewModel
        self.action = action
    }

    // MARK: View

    var body: some View {
        VStack(alignment: .center) {
            CommentView(viewModel: viewModel.comment)
                .frame(maxWidth: .infinity)

            if viewModel.answers != nil {
                Divider()
            }

            answersButton
                .padding(.top, 4.0)
                .buttonStyle(RepliesButtonStyle())
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: .cornerRadius)
                .foregroundStyle(Color(uiColor: UIColor.secondarySystemBackground))
        )
    }

    // MARK: Private

    private var answersButton: some View {
        viewModel.answers.map { answer in
            Button(action: {
                action()
            }, label: {
                Text(answer)
            })
        }
    }
}

// MARK: ShortCommentView.ViewModel

extension ShortCommentView {
    struct ViewModel: Equatable, Identifiable {
        let id: Int
        let comment: CommentView.ViewModel
        let answers: String?
    }
}

// MARK: - Constants

private extension CGFloat {
    static let cornerRadius = 16.0
}

// MARK: Preview

// #Preview {
//    ShortCommentView(
//        viewModel: ShortCommentView.ViewModel(
//            id: 1,
//            comment: CommentView.ViewModel(
//                username: "nsvasilev",
//                date: "22 hours ago",
//                text: "Comment text"
//            ),
//            answers: "8 Replies"
//        ),
//        action: {}
//    )
// }
