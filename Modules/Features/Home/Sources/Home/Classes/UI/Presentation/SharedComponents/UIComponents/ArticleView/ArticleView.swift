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
        VStack(alignment: .leading) {
            headerView

            titleView
                .padding(.vertical, 4.0)

            Divider()

            footerView
        }
        .fixedSize(horizontal: false, vertical: true)
    }

    // MARK: Private

    private var headerView: some View {
        HStack(alignment: .center) {
            imageView

            viewModel.link.map {
                Text($0)
                    .font(FontFamily.Montserrat.medium.font(size: .size12).sui)
                    .foregroundColor(Color.orange)
                    .lineLimit(1)
            }
        }
    }

    private var titleView: some View {
        Text(viewModel.title)
            .font(FontFamily.Montserrat.semiBold.font(size: .size17).sui)
            .lineLimit(.lineLimit)
    }

    private var imageView: some View {
        viewModel.imageURL.map {
            ImageView(url: $0)
                .frame(width: .headerImageSize, height: .headerImageSize)
                .background(Color.white)
                .clipShape(Circle())
        }
    }

    private var footerView: some View {
        HStack {
            IndicatorView(viewModel: IndicatorView.ViewModel(imageName: .arrowUp, text: viewModel.rating))
            Divider()
            IndicatorView(viewModel: IndicatorView.ViewModel(imageName: .person, text: viewModel.author))
            Divider()
            IndicatorView(viewModel: IndicatorView.ViewModel(imageName: .comments, text: "\(viewModel.numberOfComments)"))
            Divider()
            IndicatorView(viewModel: IndicatorView.ViewModel(imageName: .calendar, text: viewModel.date))
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
        let date: String
        let imageURL: URL?
        let url: URL?
    }
}

// MARK: - Constants

private extension Int {
    static let lineLimit = 2
}

// MARK: Constants

private extension CGFloat {
    static let headerSpacing = 4.0
    static let headerImageSize = 12.0
}

private extension String {
    static let arrowUp = "arrow.up.circle.fill"
    static let person = "person.circle.fill"
    static let calendar = "calendar.circle.fill"
    static let comments = "line.3.horizontal.circle.fill"
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
        date: "22 hours ago",
        imageURL: nil,
        url: nil
    )

    struct ArticleView_Previews: PreviewProvider {
        static var previews: some View {
            ArticleView(viewModel: viewModel)
        }
    }

#endif
