//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

// MARK: - IPostDetailViewModelFactory

protocol IPostDetailViewModelFactory {
    func makeViewModel(from comment: Comment) -> ShortCommentView.ViewModel
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

    func makeViewModel(from comment: Comment) -> ShortCommentView.ViewModel {
        ShortCommentView.ViewModel(
            id: comment.id,
            comment: makeViewModel(from: comment),
            answers: comment.kids.count == .zero ? nil : "Expand the branch (\(comment.kids.count) Replies)"
        )
    }

    // MARK: Private

    private func makeViewModel(from comment: Comment) -> CommentView.ViewModel {
        CommentView.ViewModel(
            username: comment.author ?? "Unknown",
            date: dateTimeFormatter.localizedString(
                for: Date(timeIntervalSince1970: TimeInterval(comment.time)),
                relativeTo: Date()
            ),
            text: comment.text ?? ""
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
