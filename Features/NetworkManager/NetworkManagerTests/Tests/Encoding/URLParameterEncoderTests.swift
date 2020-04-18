//
//  URLParameterEncoderTests.swift
//  NetworkManagerTests
//
//  Created by Никита Васильев on 18.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import XCTest
@testable import NetworkManager

class URLParameterEncoderTests: XCTestCase {

    // MARK: Private Properties
    private let url = URL(string: "https://google.com/")
    
    // MARK: Initialization
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    // MARK: Tests
    func testThatURLParameterEncodingSuccessfully() throws {
        let url = try XCTUnwrap(self.url, "Couldn't instantiate url")
        
        var urlRequest = URLRequest(url: url)
        let parameters: Parameters = [
            "userID": 1,
            "Name": "Max",
            "EMail": "test@test.com"
        ]
        
        do {
            try URLParameterEncoder.encode(urlRequest: &urlRequest, with: parameters)
            
            let fullURL = try XCTUnwrap(urlRequest.url, "urlRequest url is nil")
            let expectedUrl = "\(url.absoluteString)?EMail=test%2540test.com&userID=1&Name=Max"
            
            XCTAssertEqual(fullURL.absoluteString.sorted(), expectedUrl.sorted(), "String doesn't equal")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testThatURLParameterEncodingFailWhenURLIsNotValid() throws {
        let parameters: Parameters = [:]
        let url = try XCTUnwrap(self.url, "Couldn't instantiate url")
        var urlRequest = URLRequest(url: url)
        urlRequest.url = nil
        
        XCTAssertThrowsError(try URLParameterEncoder.encode(urlRequest: &urlRequest, with: parameters))
    }
}
