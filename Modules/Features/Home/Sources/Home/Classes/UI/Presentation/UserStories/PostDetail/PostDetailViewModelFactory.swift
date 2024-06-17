//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

// MARK: - IPostDetailViewModelFactory

protocol IPostDetailViewModelFactory {
    func makeViewModel(from comment: Comment) -> CommentView.ViewModel
}

// MARK: - PostDetailViewModelFactory

struct PostDetailViewModelFactory: IPostDetailViewModelFactory {
    func makeViewModel(from comment: Comment) -> CommentView.ViewModel {
        CommentView.ViewModel(title: comment.author ?? "Unknown", text: comment.text ?? "")
    }
}
