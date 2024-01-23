//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

// MARK: - IPostViewModelFactory

protocol IPostViewModelFactory {
    func makeViewModel(from post: Post) -> ArticleView.ViewModel
}

// MARK: - PostViewModelFactory

final class PostViewModelFactory: IPostViewModelFactory {
    // MARK: IPostViewModelFactory

    func makeViewModel(from post: Post) -> ArticleView.ViewModel {
        ArticleView.ViewModel(
            title: post.title ?? "",
            author: post.author ?? "Unknown",
            link: makeLink(post.url),
            rating: String(post.score ?? 0),
            numberOfComments: post.kids.count,
            imageURL: makeImageURL(post.url)
        )
    }

    // MARK: Private

    private func makeLink(_ link: String?) -> String? {
        guard let link = link, let url = URL(string: link) else { return nil }
        return url.host()
    }

    private func makeImageURL(_ urlString: String?) -> URL? {
        guard let urlString = urlString, let url = URL(
            string: .extractURL + urlString
        ) else { return nil }
        return url
    }
}

// MARK: - Constants

private extension String {
    static let extractURL = "http://www.google.com/s2/favicons?sz=64&domain="
}
