//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import SwiftUI

// MARK: - SegmentControlItemView

struct SegmentControlItemView<ID: Identifiable, ContentView: View, BackgroundView: Shape>: View {
    // MARK: Properties

    let id: ID
    let action: (() -> Void)?
    @Binding var selection: ID
    @ViewBuilder var content: () -> ContentView
    @ViewBuilder var background: () -> BackgroundView

    // MARK: View

    var body: some View {
        Button(
            action: {
                withAnimation {
                    selection = id
                    action?()
                }
            }, label: {
                content()
            }
        )
        .clipShape(background())
    }
}

#if DEBUG
    struct SegmentControlItemView_Previews: PreviewProvider {
        static var previews: some View {
            SegmentControlItemView(
                id: PostType.new,
                action: nil,
                selection: .constant(.new),
                content: { Text(PostType.new.title) },
                background: { RoundedRectangle(cornerRadius: 20) }
            )
        }
    }
#endif
