//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

// MARK: - IRepliesViewModelFactory

protocol IRepliesViewModelFactory {
    func makeViewModel(from reply: ReplyComment) -> [RepliesCommentView.ViewModel]
}

// MARK: - RepliesViewModelFactory

final class RepliesViewModelFactory: IRepliesViewModelFactory {
    // MARK: Properties

    private let dateTimeFormatter: RelativeDateTimeFormatter

    // MARK: Initialization

    init(dateTimeFormatter: RelativeDateTimeFormatter) {
        self.dateTimeFormatter = dateTimeFormatter
    }

    // MARK: IRepliesViewModelFactory

    func makeViewModel(from reply: ReplyComment) -> [RepliesCommentView.ViewModel] {
        makeViewModel(from: reply, level: 0)
    }

    // MARK: Private

    private func makeViewModel(from reply: ReplyComment, level: Int) -> [RepliesCommentView.ViewModel] {
        let comment = makeViewModel(from: reply.comment)

        var comments: [RepliesCommentView.ViewModel] = [RepliesCommentView.ViewModel(comment: comment, level: level)]

        if reply.replies.isEmpty {
            return comments
        }

        for reply in reply.replies {
            let replies = makeViewModel(from: reply, level: level + 1)
            comments.append(contentsOf: replies)
        }

        return comments
    }

    private func makeViewModel(from comment: Comment) -> CommentView.ViewModel {
        CommentView.ViewModel(
            username: comment.author ?? "",
            date: dateTimeFormatter.localizedString(
                for: Date(timeIntervalSince1970: TimeInterval(comment.time)),
                relativeTo: Date()
            ),
            text: comment.text ?? ""
        )
    }
}
