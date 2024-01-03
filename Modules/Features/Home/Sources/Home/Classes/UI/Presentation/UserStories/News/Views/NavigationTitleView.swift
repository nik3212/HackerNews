//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import DesignKit
import SwiftUI

struct NavigationTitleView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Tue, Jan 2")
                .font(FontFamily.Montserrat.semiBold.font(size: .size13).sui)
            Text("Hacker News")
                .font(FontFamily.Montserrat.bold.font(size: .size17).sui)
        }
    }
}
