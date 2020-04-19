//
//  BaseResource.swift
//  HackerNews
//
//  Created by Никита Васильев on 19.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation
import NetworkManager

class BaseResource<Model: Decodable>: APIResource {
    typealias ModelType = Model

    var baseURL: URL {
        // swiftlint:disable force_unwrapping
        return URL(string: Constants.Endpoints.base)!
        // swiftlint:enable force_unwrapping
    }

    var path: String {
        return ""
    }
    
    var httpHeaders: HTTPHeaders? {
        return nil
    }

    var bodyParameters: Parameters? {
        return nil
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        return .request
    }

    var cachePolicy: URLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }

    var timeout: TimeInterval {
        return 30
    }
}
