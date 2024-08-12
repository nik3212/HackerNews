//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation
import HackerNewsLocalization

// MARK: - IPostViewModelFactory

protocol IPostViewModelFactory {
    func makeViewModel(from post: Post) -> ArticleView.ViewModel
}

// MARK: - PostViewModelFactory

final class PostViewModelFactory: IPostViewModelFactory {
    // MARK: Properties

    private let dateTimeFormatter: RelativeDateTimeFormatter

    // MARK: Initialization

    init(dateTimeFormatter: RelativeDateTimeFormatter) {
        self.dateTimeFormatter = dateTimeFormatter
    }

    // MARK: IPostViewModelFactory

    func makeViewModel(from post: Post) -> ArticleView.ViewModel {
        ArticleView.ViewModel(
            articleID: post.id,
            title: post.title ?? "",
            author: post.author ?? L10n.Comment.User.unknown,
            link: makeLink(post.url),
            rating: String(post.score ?? 0),
            numberOfComments: post.kids.count,
            date: dateTimeFormatter.localizedString(
                for: Date(
                    timeIntervalSince1970: TimeInterval(post.time)
                ),
                relativeTo: Date()
            ),
            imageURL: makeImageURL(post.url),
            url: makeURL(post.url)
        )
    }

    // MARK: Private

    private func makeLink(_ link: String?) -> String? {
        guard let link, let url = URL(string: link) else { return nil }
        return url.host()
    }

    private func makeImageURL(_ urlString: String?) -> URL? {
        guard let urlString, let url = URL(
            string: .extractURL + urlString
        ) else { return nil }
        return url
    }

    private func makeURL(_ urlString: String?) -> URL? {
        guard let urlString, let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
}

// MARK: - Constants

private extension String {
    static let extractURL = "http://www.google.com/s2/favicons?sz=64&domain="
}
