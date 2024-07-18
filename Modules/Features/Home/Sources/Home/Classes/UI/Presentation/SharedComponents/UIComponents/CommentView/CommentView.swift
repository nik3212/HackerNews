//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import SwiftUI
import UIExtensions

// MARK: - CommentView

struct CommentView: View {
    // MARK: Properties

    let viewModel: ViewModel

    // MARK: View

    var body: some View {
        VStack(alignment: .leading) {
            headerView

            Divider()

            contentView
        }
        .fixedSize(horizontal: false, vertical: true)
    }

    private var headerView: some View {
        HStack(alignment: .center) {
            headerItemView(
                systemName: .person,
                text: viewModel.username
            )

            Divider()

            headerItemView(
                systemName: .calendar,
                text: viewModel.date
            )
        }
    }

    private var contentView: some View {
        VStack(alignment: .leading) {
            Text(AttributedString(.html(withBody: viewModel.text)))
        }
    }

    @ViewBuilder
    private func headerItemView(systemName: String, text: String) -> some View {
        HStack(spacing: .headerSpacing) {
            Image(systemName: systemName)
                .resizable()
                .frame(width: .headerImageSize, height: .headerImageSize)
                .foregroundStyle(Color(uiColor: UIColor.secondaryLabel))
            Text(text)
                .font(.caption)
                .foregroundStyle(Color(uiColor: UIColor.secondaryLabel))
        }
    }
}

// MARK: CommentView.ViewModel

extension CommentView {
    struct ViewModel: Equatable, Identifiable {
        let id = UUID()
        let username: String
        let date: String
        let text: String
    }
}

// MARK: Constants

private extension CGFloat {
    static let headerSpacing = 4.0
    static let headerImageSize = 12.0
}

private extension String {
    static let person = "person.circle.fill"
    static let calendar = "calendar.circle.fill"
}

// MARK: Preview

// #Preview {
//    CommentView(
//        viewModel: CommentView.ViewModel(
//            username: "nsvasilev",
//            date: "22 hours ago",
//            text: "Comment message"
//        )
//    )
// }
