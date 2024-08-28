//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import SwiftUI

// MARK: - SegmentControlView

struct SegmentControlView<ID: Identifiable, ContentView: View, BackgroundView: Shape>: View {
    // MARK: Properties

    let segments: [ID]
    @Binding var selection: ID
    @ViewBuilder var content: (ID) -> ContentView
    @ViewBuilder var background: () -> BackgroundView

    // MARK: View

    var body: some View {
        ScrollViewReader { value in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Array(segments.enumerated()), id: \.offset) { index, segment in
                        SegmentControlItemView(
                            id: segment,
                            action: { value.scrollTo(index) },
                            selection: $selection,
                            content: { content(segment) },
                            background: { background() }
                        )
                        .id(index)
                        .fixedSize()
                    }
                }
                .padding(.horizontal, 20.0)
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
    struct SegmentControlView_Previews: PreviewProvider {
        static var previews: some View {
            SegmentControlView(
                segments: PostType.allCases,
                selection: .constant(.new),
                content: { Text($0.title) },
                background: { RoundedRectangle(cornerRadius: 20) }
            )
        }
    }
#endif
