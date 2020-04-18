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
        return URL(string: "https://test.com/")!
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
    
    private let corruptDataString = String(bytes: [0xD8, 0x00] as [UInt8], encoding: .utf16BigEndian)!
    
    private var urlParameters: Parameters {
        return [corruptDataString: corruptDataString]
    }
}
