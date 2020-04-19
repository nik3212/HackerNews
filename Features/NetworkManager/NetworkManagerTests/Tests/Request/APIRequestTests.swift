//
//  APIRequestTests.swift
//  NetworkManagerTests
//
//  Created by Никита Васильев on 18.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import XCTest
@testable import NetworkManager

class APIRequestTests: XCTestCase {
    
    // MARK: Private Properties
    private let resource = MockResource()
    private var apiRequest: APIRequest<MockResource>!
    
    // MARK: Initialization
    override func setUp() {
        super.setUp()
        apiRequest = APIRequest(resource: resource)
    }
    
    override func tearDown() {
        super.tearDown()
    }

    // MARK: Tests
    func testThatAPIRequestInitCorrect() {
        XCTAssertEqual(resource, apiRequest.resource, "resource in apiRequest should be equal to resource")
    }
    
    func testThatURLRequestBuildSuccessfully() throws {
        let request = try XCTUnwrap(apiRequest.buildRequest())
        let fullURL = try XCTUnwrap(request.url, "urlRequest url is nil")
        let resourceURL = resource.baseURL.appendingPathComponent(resource.path)
        XCTAssertEqual(fullURL.absoluteString.sorted(), resourceURL.absoluteString.sorted(), "request url is not correct")
    }
}
