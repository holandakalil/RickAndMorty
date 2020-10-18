//
//  MockURLProtocol.swift
//  Rick and MortyTests
//
//  Created by Kalil Holanda on 12/10/20.
//

import Foundation
@testable import Rick_and_Morty

class MockURLProtocol: URLProtocol {
    
    static var stubResponseData: Data?
    static var error: CharacterError?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let mockError = MockURLProtocol.error {
            self.client?.urlProtocol(self, didFailWithError: mockError)
        } else {
            self.client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data())
        }
 
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
}
