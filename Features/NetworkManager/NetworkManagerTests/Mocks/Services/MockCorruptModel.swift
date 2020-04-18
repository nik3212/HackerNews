//
//  MockCorruptModel.swift
//  NetworkManagerTests
//
//  Created by Никита Васильев on 19.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation
@testable import NetworkManager

struct MockCorruptParametersModel: APIResource {
    typealias ModelType = MockModel
    
    var baseURL: URL {
        return URL(string: "https://test.com/")!
    }
    
    var path: String {
        return "path/"
    }
    
    var bodyParameters: Parameters? {
        return [corruptDataString: corruptDataString]
    }
    
    var task: HTTPTask {
        .requestParameters(bodyParameters: bodyParameters, urlParameters: nil)
    }
    
    private let corruptDataString = String(bytes: [0xD8, 0x00] as [UInt8], encoding: .utf16BigEndian)!
}
