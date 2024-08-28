//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

// MARK: - IDateFormatter

public protocol IDateFormatter {
    func string(from date: Date) -> String
}

// MARK: - DateFormatter + IDateFormatter

extension DateFormatter: IDateFormatter {}
