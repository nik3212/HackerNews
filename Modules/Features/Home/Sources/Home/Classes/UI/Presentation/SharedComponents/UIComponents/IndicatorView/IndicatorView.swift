//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import SwiftUI

// MARK: - IndicatorView

struct IndicatorView: View {
    // MARK: Properties

    private let viewModel: ViewModel

    // MARK: Initialization

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: View

    var body: some View {
        HStack(spacing: .headerSpacing) {
            Image(systemName: viewModel.imageName)
                .resizable()
                .frame(width: .headerImageSize, height: .headerImageSize)
                .foregroundStyle(Color(uiColor: UIColor.secondaryLabel))
            Text(viewModel.text)
                .lineLimit(1)
                .font(.caption)
                .foregroundStyle(Color(uiColor: UIColor.secondaryLabel))
        }
    }
}

// MARK: IndicatorView.ViewModel

extension IndicatorView {
    struct ViewModel {
        let imageName: String
        let text: String
    }
}

// MARK: Constants

private extension CGFloat {
    static let headerSpacing = 4.0
    static let headerImageSize = 12.0
}
