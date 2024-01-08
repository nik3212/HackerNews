//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

// MARK: - IPostViewModelFactory

protocol IPostViewModelFactory {
    func makeViewModel(from posts: [Post]) -> [ArticleView.ViewModel]
}

// MARK: - PostViewModelFactory

final class PostViewModelFactory: IPostViewModelFactory {
    // MARK: IPostViewModelFactory

    func makeViewModel(from posts: [Post]) -> [ArticleView.ViewModel] {
        posts.map { post in
            ArticleView.ViewModel(
                title: post.title ?? "",
                author: post.author ?? "Unknown",
                link: makeLink(post.url),
                rating: String(post.score ?? 0),
                numberOfComments: post.kids.count,
                imageURL: nil
            )
        }
    }

    // MARK: Private

    private func makeLink(_ link: String?) -> String? {
        guard let link = link, let url = URL(string: link) else { return nil }
        return url.host()
    }
}
