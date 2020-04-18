//
//  JSONParameterEncoderTests.swift
//  NetworkManagerTests
//
//  Created by Никита Васильев on 18.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import XCTest
@testable import NetworkManager

class JSONParameterEncoderTests: XCTestCase {

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
    func testThatJSONEncodingSuccessfully() throws {
        let url = try XCTUnwrap(self.url, "Couldn't instantiate url")
        
        var urlRequest = URLRequest(url: url)
        let parameters: Parameters = [
            "userID": 1,
            "Name": "Max",
            "EMail": "test@test.com"
        ]
        
        do {
            try JSONParameterEncoder.encode(urlRequest: &urlRequest, with: parameters)
            
            let fullURL = try XCTUnwrap(urlRequest.url, "urlRequest url is nil")
            XCTAssertEqual(fullURL.absoluteURL, url)
            
            let body = try XCTUnwrap(urlRequest.httpBody, "body in urlRequest is nil")
            let json = try JSONSerialization.jsonObject(with: body, options: .mutableContainers)
            XCTAssertNotNil(json, "Unable to deserialize json")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThatJSONEncodingFailedWhenParametersInNotValid() throws {
        let url = try XCTUnwrap(self.url, "Couldn't instantiate url")
        let failedString = try XCTUnwrap(String(bytes: [0xD8, 0x00] as [UInt8], encoding: .utf16BigEndian), "Couldn't create a string")
        var urlRequest = URLRequest(url: url)
        let parameters: Parameters = [failedString: failedString]
        
        XCTAssertThrowsError(try JSONParameterEncoder.encode(urlRequest: &urlRequest, with: parameters))
    }
}
