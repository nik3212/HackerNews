//
//  MockCorruptParametersModel.swift
//  NetworkManagerTests
//
//  Created by Никита Васильев on 19.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

@testable import NetworkManager

struct MockCorruptParametersWithHeaderResource: APIResource {
    typealias ModelType = MockModel
    
    var baseURL: URL {
        // swiftlint:disable force_unwrapping
        return URL(string: "https://test.com/")!
        // swiftlint:enable force_unwrapping
    }
    
    var path: String {
        return "path/"
    }
    
    var bodyParameters: Parameters? {
        return [corruptDataString: corruptDataString]
    }
    
    var task: HTTPTask {
        .requestParametersAndHeaders(bodyParameters: bodyParameters, urlParameters: urlParameters, headers: httpHeaders)
    }
    
    var httpHeaders: HTTPHeaders? {
        return ["some": "text"]
    }
    
    // swiftlint:disable force_unwrapping
    private let corruptDataString = String(bytes: [0xD8, 0x00] as [UInt8], encoding: .utf16BigEndian)!
    // swiftlint:enable force_unwrapping
    
    private var urlParameters: Parameters {
        return [corruptDataString: corruptDataString]
    }
}
