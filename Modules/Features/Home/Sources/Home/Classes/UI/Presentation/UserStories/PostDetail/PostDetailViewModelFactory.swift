//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation
import HackerNewsLocalization

// MARK: - IPostDetailViewModelFactory

protocol IPostDetailViewModelFactory {
    func makeViewModel(from comment: Comment) -> ShortCommentView.ViewModel?
}

// MARK: - PostDetailViewModelFactory

struct PostDetailViewModelFactory: IPostDetailViewModelFactory {
    // MARK: Properties

    private let dateTimeFormatter: RelativeDateTimeFormatter

    // MARK: Initialization

    init(dateTimeFormatter: RelativeDateTimeFormatter) {
        self.dateTimeFormatter = dateTimeFormatter
    }

    // MARK: IPostDetailViewModelFactory

    func makeViewModel(from comment: Comment) -> ShortCommentView.ViewModel? {
        guard let commentVM: CommentView.ViewModel = makeViewModel(from: comment) else { return nil }

        return ShortCommentView.ViewModel(
            id: comment.id,
            comment: commentVM,
            answers: comment.kids.count == .zero ? nil : L10n.Comment.expandBranch(comment.kids.count)
        )
    }

    // MARK: Private

    private func makeViewModel(from comment: Comment) -> CommentView.ViewModel? {
        guard let text = comment.text, !comment.text.isNilOrEmpty else {
            return nil
        }
        return CommentView.ViewModel(
            username: comment.author ?? L10n.Comment.User.unknown,
            date: dateTimeFormatter.localizedString(
                for: Date(timeIntervalSince1970: TimeInterval(comment.time)),
                relativeTo: Date()
            ),
            text: text
        )
    }
}

extension RelativeDateTimeFormatter {
    static let standard: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter
    }()
}
