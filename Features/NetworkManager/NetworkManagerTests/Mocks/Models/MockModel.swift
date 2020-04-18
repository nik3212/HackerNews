//
//  MockModel.swift
//  NetworkManagerTests
//
//  Created by Никита Васильев on 18.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

struct MockModel: Codable {
    let id: String
    let name: String
}

// MARK: Equatable
extension MockModel: Equatable { }
