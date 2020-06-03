//
//  MockResource.swift
//  NetworkManagerTests
//
//  Created by Никита Васильев on 18.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation
@testable import NetworkManager

struct MockResource: APIResource {
    typealias ModelType = MockModel
    
    var baseURL: URL {
        // swiftlint:disable force_unwrapping
        return URL(string: "https://test.com/")!
        // swiftlint:enable force_unwrapping
    }
    
    var path: String {
        return "path/"
    }
}

// MARK: Equatable
extension MockResource: Equatable { }
