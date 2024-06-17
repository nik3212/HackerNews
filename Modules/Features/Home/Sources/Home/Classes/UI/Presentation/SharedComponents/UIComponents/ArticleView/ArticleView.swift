//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import DesignKit
import HackerNewsLocalization
import SwiftUI

// MARK: - ArticleView

struct ArticleView: View {
    // MARK: Properties

    private let viewModel: ViewModel

    // MARK: Initialization

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: View

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8.0) {
                VStack(alignment: .leading, spacing: 4.0) {
                    headerView
                    titleView
                }
                VStack(alignment: .leading, spacing: 4.0) {
                    authorInfoView
                    articleFeedbackView
                }
            }
            Spacer(minLength: 16.0)
            imageView
        }
    }

    // MARK: Private

    private var headerView: some View {
        viewModel.link.map {
            Text($0)
                .font(FontFamily.Montserrat.medium.font(size: .size13).sui)
                .foregroundColor(Color.orange)
                .lineLimit(1)
        }
    }

    private var titleView: some View {
        Text(viewModel.title)
            .font(FontFamily.Montserrat.semiBold.font(size: .size17).sui)
            .lineLimit(.lineLimit)
    }

    private var authorInfoView: some View {
        Text(viewModel.author)
            .font(FontFamily.Montserrat.medium.font(size: .size13).sui)
    }

    private var articleFeedbackView: some View {
        HStack(spacing: 4.0) {
            ratingView
            Text(String.dot)
            commentsView
        }
        .font(FontFamily.Montserrat.regular.font(size: .size13).sui)
    }

    private var ratingView: some View {
        HStack(spacing: 4.0) {
            Image(systemName: .arrowUp)
            Text(viewModel.rating)
        }
    }

    private var commentsView: some View {
        Text(L10n.News.Article.comments(viewModel.numberOfComments))
    }

    private var imageView: some View {
        viewModel.imageURL.map {
            ImageView(url: $0)
                .frame(width: 64, height: 64)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
        }
    }
}

// MARK: ArticleView.ViewModel

extension ArticleView {
    struct ViewModel: Equatable, Identifiable {
        let id = UUID()
        let articleID: Int
        let title: String
        let author: String
        let link: String?
        let rating: String
        let numberOfComments: Int
        let imageURL: URL?
    }
}

// MARK: - Constants

private extension Int {
    static let lineLimit = 2
}

private extension String {
    static let arrowUp = "arrow.up"
    static let dot = "•"
}

// MARK: - Preview

#if DEBUG

    private var viewModel = ArticleView.ViewModel(
        articleID: .zero,
        title: "Proton Mail Rewrites Your Emails",
        author: "jamesik",
        link: "x64.sh",
        rating: "64",
        numberOfComments: 30,
        imageURL: nil
    )

    struct ArticleView_Previews: PreviewProvider {
        static var previews: some View {
            ArticleView(viewModel: viewModel)
        }
    }

#endif
