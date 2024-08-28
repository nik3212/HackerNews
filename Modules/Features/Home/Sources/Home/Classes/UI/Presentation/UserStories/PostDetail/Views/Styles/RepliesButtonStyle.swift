//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import SwiftUI

struct RepliesButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(configuration.isPressed ? Color.orange.opacity(0.8) : Color.orange)
            .font(.footnote)
            .fontWeight(.bold)
    }
}
