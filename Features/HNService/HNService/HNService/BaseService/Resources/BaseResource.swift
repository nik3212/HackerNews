//
//  BaseResource.swift
//  HackerNews
//
//  Created by Никита Васильев on 19.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation
import NetworkManager

public class BaseResource<Model: Decodable>: APIResource {
    public typealias ModelType = Model

    public var baseURL: URL {
        // swiftlint:disable force_unwrapping
        return URL(string: Constants.Endpoints.base)!
        // swiftlint:enable force_unwrapping
    }

    public var path: String {
        return ""
    }
    
    public var httpHeaders: HTTPHeaders? {
        return nil
    }

    public var bodyParameters: Parameters? {
        return nil
    }

    public var httpMethod: HTTPMethod {
        return .get
    }

    public var task: HTTPTask {
        return .request
    }

    public var cachePolicy: URLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }

    public var timeout: TimeInterval {
        return 30
    }
}
