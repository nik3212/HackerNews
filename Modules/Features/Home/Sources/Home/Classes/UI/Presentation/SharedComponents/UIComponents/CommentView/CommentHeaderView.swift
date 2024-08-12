//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import SwiftUI

// MARK: - CommentHeaderView

struct CommentHeaderView: View {
    private let viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack(alignment: .center) {
            IndicatorView(viewModel: .init(imageName: .person, text: viewModel.username))

            Divider()

            IndicatorView(viewModel: .init(imageName: .calendar, text: viewModel.date))
        }
    }
}

// MARK: CommentHeaderView.ViewModel

extension CommentHeaderView {
    struct ViewModel {
        let username: String
        let date: String
    }
}

private extension String {
    static let person = "person.circle.fill"
    static let calendar = "calendar.circle.fill"
}
