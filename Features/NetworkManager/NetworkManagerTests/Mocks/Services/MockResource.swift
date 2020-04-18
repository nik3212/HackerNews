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
        return URL(string: "https://test.com/")!
    }
    
    var path: String {
        return "path/"
    }
}

// MARK: Equatable
extension MockResource: Equatable { }
