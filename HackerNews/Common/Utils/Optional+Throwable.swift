//
//  Optional+Throwable.swift
//  HackerNews
//
//  Created by Никита Васильев on 16.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

extension Optional {
    func unwrap() -> Wrapped {
        switch self {
        case .some(let result):
            return result
        default:
            fatalError("Cann't unwrap value")
        }
    }
}
