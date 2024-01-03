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
            VStack(alignment: .leading) {
                headerView
                VStack(alignment: .leading, spacing: 2.0) {
                    titleView
                    authorInfoView
                }
                articleFeedbackView
            }
            imageView
        }
    }

    // MARK: Private

    private var headerView: some View {
        HStack {
            Text(viewModel.link)
                .font(FontFamily.Montserrat.regular.font(size: .size13).sui)
        }
    }

    private var titleView: some View {
        Text(viewModel.title)
            .font(FontFamily.Montserrat.semiBold.font(size: .size17).sui)
            .lineLimit(.lineLimit)
    }

    private var authorInfoView: some View {
        HStack {
            Text(viewModel.author)
        }
        .font(FontFamily.Montserrat.regular.font(size: .size15).sui)
    }

    private var articleFeedbackView: some View {
        HStack {
            Text(String(viewModel.rating))
            Text(L10n.News.Article.comments(viewModel.numberOfComments))
        }
        .font(FontFamily.Montserrat.regular.font(size: .size15).sui)
    }

    private var imageView: some View {
        self.viewModel.imageURL.map {
            ImageView(url: $0)
                .frame(width: 50, height: 50)
        }
    }
}

// MARK: - ViewModel

extension ArticleView {
    struct ViewModel {
        let title: String
        let author: String
        let link: String
        let rating: Int
        let numberOfComments: Int
        let imageURL: URL?
    }
}

// MARK: - Constants

private extension Int {
    static let lineLimit = 2
}

// MARK: - Preview

#if DEBUG

    private var viewModel = {
        ArticleView.ViewModel(
            title: "Proton Mail Rewrites Your Emails",
            author: "jamesik",
            link: "x64.sh",
            rating: 64,
            numberOfComments: 30,
            imageURL: nil
        )
    }()

    struct ArticleView_Previews: PreviewProvider {
        static var previews: some View {
            ArticleView(viewModel: viewModel)
        }
    }

#endif
