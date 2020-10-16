//
//  CharacterWebServiceTests.swift
//  Rick and MortyTests
//
//  Created by Kalil Holanda on 12/10/20.
//

import XCTest
@testable import Rick_and_Morty

class CharacterWebServiceTests: XCTestCase {
    
    var sut: CharacterWebService!
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        sut = CharacterWebService(urlString: Constants.characterUrl, urlSession: urlSession)
    }
    
    override func tearDown() {
        sut = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }
    
    // MARK: - Successful response
    func testCharacterWebService_GetAllCharacters_WhenGivenSuccessfullResponse_ReturnsSuccess() {
        
        // Arrange
        let countTest = 123
        let nameTest = "Name test"
        let locationNameTest = "Location Name Test"
        
        let jsonString = """
            {
              "info": {
                "count": \(countTest),
                "pages": 20,
                "next": "https://rickandmortyapi.com/api/character/?page=20",
                "prev": "https://rickandmortyapi.com/api/character/?page=18"
              },
              "results": [
                {
                  "id": 361,
                  "name": "\(nameTest)",
                  "status": "Dead",
                  "species": "Humanoid",
                  "type": "Rick's Toxic Side",
                  "gender": "Male",
                  "origin": {
                    "name": "Alien Spa",
                    "url": "https://rickandmortyapi.com/api/location/64"
                  },
                  "location": {
                    "name": "\(locationNameTest)",
                    "url": "https://rickandmortyapi.com/api/location/20"
                  },
                  "image": "https://rickandmortyapi.com/api/character/avatar/361.jpeg",
                  "episode": [
                    "https://rickandmortyapi.com/api/episode/27"
                  ],
                  "url": "https://rickandmortyapi.com/api/character/361",
                  "created": "2018-01-10T18:20:41.703Z"
                },
              ]
            }
        """
        
        MockURLProtocol.stubResponseData =  jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "CharacterWebService getAllCharacters Response Expectation")
        
        // Act
        sut.getCharacters(at: 1) { (allCharactersResponseModel, error) in
            
            // Assert
            XCTAssertEqual(allCharactersResponseModel?.info.count, countTest, "Expected count to be the sabe as mock")
            XCTAssertEqual(allCharactersResponseModel?.results.first?.name, nameTest, "Expected name to be the sabe as mock")
            XCTAssertEqual(allCharactersResponseModel?.results.first?.location.name, locationNameTest, "Expected location name to be the sabe as mock")
            expectation.fulfill()
            
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    // MARK: - Bad Url
    func testCharacterWebService_GetAllCharacters_WhenGivenBadUrl_ReturnsError() {
        // Arrange
        sut = CharacterWebService(urlString: "")
        let expectation = self.expectation(description: "An empty request URL string expectation")
        
        // Act
        sut.getCharacters { (allCharactersResponseModel, error) in
            // Assert
            XCTAssertEqual(error, CharacterError.invalidRequestURLString, "getAllCharacters() did not return an expected error for an invalidRequestURLString error")
            XCTAssertNil(allCharactersResponseModel, "When an invalidRequestURLString takes place, the response model must be nil")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    // MARK: Unexpected response
    func testCharacterWebService_GetAllCharacters_WhenReceivedDifferentJSONResponse_ReturnsError() {
        // Arrange
        let jsonString = "{\"path\":\"/characters\", \"error\":\"Internal Server Error\"}"
        MockURLProtocol.stubResponseData =  jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "getAllCharacters() method expectation for a response that contains a different JSON structure")
        
        // Act
        sut.getCharacters { (allCharactersResponseModel, error) in
            // Assert
            XCTAssertNil(allCharactersResponseModel, "Unknown JSON, response model expected nil")
            XCTAssertEqual(error, CharacterError.invalidResponseModel, "getAllCharacters() did not return expected error")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    // MARK: - Return message description
    func testCharacterWebService_GetAllCharacters_WhenURLRequestFails_ReturnsErrorMessageDescription() {
        // Arrange
        let expectation = self.expectation(description: "A failed Request expectation")
        let errorDescription = "A localized description of an error"
        MockURLProtocol.error = CharacterError.failedRequest(description: errorDescription)
        
        // Act
        sut.getCharacters { (allCharactersResponseModel, error) in
            // Assert
//            XCTAssertEqual(error, CharacterError.failedRequest(description: errorDescription),
//                           "getCharacters() did not return an expecter error for the Failed Request")
            XCTAssertNotNil(error, "getCharacters() expected error not nil")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
    }
}
