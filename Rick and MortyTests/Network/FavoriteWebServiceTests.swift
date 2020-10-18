//
//  FavoriteWebService.swift
//  Rick and MortyTests
//
//  Created by Kalil Holanda on 16/10/20.
//

import XCTest
@testable import Rick_and_Morty

class FavoriteWebServiceTests: XCTestCase {
    
    var sut: FavoriteWebService!
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        sut = FavoriteWebService(urlString: Constants.characterUrl, urlSession: urlSession)
    }
    
    override func tearDown() {
        sut = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }
    
    func testFavoriteWebService_GetFavoritedCharacters_WhenGivenSuccessfullResponse_ReturnsSuccess() {
        
        // Arrange
        let nameTest = "Name test"
        let locationNameTest = "Location Name Test"
        
        let jsonString = """
                  [
                    {
                      "id": 1,
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
            """
        
        MockURLProtocol.stubResponseData =  jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "CharacterWebService getFavoritedCharacters Response Expectation")
        
        // Act
        sut.getFavoritedCharacters(with: [1], completionHandler: { (characters, error) in
            
            // Assert
            XCTAssertEqual(characters?.first?.name, nameTest, "Expected name to be the sabe as mock")
            XCTAssertEqual(characters?.first?.location.name, locationNameTest, "Expected location name to be the sabe as mock")
            XCTAssertNil(error, "Expected not to return error")
            expectation.fulfill()
            
        })
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testFavoriteWebService_GetFavoritedCharacters_WhenGivenBadUrl_ReturnsError() {
        // Arrange
        sut = FavoriteWebService(urlString: "")
        let expectation = self.expectation(description: "An empty request URL string expectation")
        
        // Act
        sut.getFavoritedCharacters(with: [1], completionHandler: { (characters, error) in
            // Assert
            XCTAssertEqual(error, CharacterError.invalidRequestURLString, "getFavoritedCharacters() did not return an expected error for an invalidRequestURLString error")
            XCTAssertNil(characters, "When an invalidRequestURLString takes place, the response model must be nil")
            expectation.fulfill()
        })
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testFavoriteWebService_GetFavoritedCharacters_WhenReceivedDifferentJSONResponse_ReturnsError() {
        // Arrange
        let jsonString = "{\"path\":\"/characters\", \"error\":\"Internal Server Error\"}"
        MockURLProtocol.stubResponseData =  jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "getAllCharacters() method expectation for a response that contains a different JSON structure")
        
        // Act
        sut.getFavoritedCharacters(with: [1,3], completionHandler: { (characters, error) in
            // Assert
            XCTAssertNil(characters, "Unknown JSON, response model expected nil")
            XCTAssertEqual(error, CharacterError.invalidResponseModel, "getFavoritedCharacters() did not return expected error")
            expectation.fulfill()
        })
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testFavoriteWebService_GetFavoritedCharacters_WhenURLRequestFails_ReturnsErrorMessageDescription() {
        // Arrange
        let expectation = self.expectation(description: "A failed Request expectation")
        let errorToSend = CharacterError.failedRequest
        MockURLProtocol.error = errorToSend
        
        // Act
        sut.getFavoritedCharacters(with: [1, 3, 20], completionHandler: { (characters, error) in
            // Assert
            XCTAssertNil(characters, "Expected characteres to return nil")
            XCTAssertEqual(error, errorToSend, "Expected failedRequest error")
            XCTAssertNotNil(error, "getFavoritedCharacters() expected error not nil")
            expectation.fulfill()
        })
        
        self.wait(for: [expectation], timeout: 2)
    }
    
    func testFavoriteWebService_GetMultipleFavoritedCharacters_Integration_ReturnsSuccess() {
        
        // Arrange
        sut = FavoriteWebService(urlString: Constants.characterUrl)
        let charactersIds = [1,3,5,10]
        let expectation = self.expectation(description: "CharacterWebService getFavoritedCharacters Response Expectation")
        
        // Act
        sut.getFavoritedCharacters(with: charactersIds, completionHandler: { (characters, error) in
            
            // Assert
            XCTAssertEqual(characters?.count, charactersIds.count, "Expected to return \(charactersIds.count) results")
            XCTAssertNil(error, "Expected not to return error")
            expectation.fulfill()
            
        })
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testFavoriteWebService_GetSingleFavoritedCharacters_Integration_ReturnsSuccess() {
        
        // Arrange
        sut = FavoriteWebService(urlString: Constants.characterUrl)
        let charactersIds = [100]
        let expectation = self.expectation(description: "CharacterWebService getFavoritedCharacters Response Expectation")
        
        // Act
        sut.getFavoritedCharacters(with: charactersIds, completionHandler: { (characters, error) in
            
            // Assert
            XCTAssertEqual(characters?.count, charactersIds.count, "Expected to return \(charactersIds.count) results")
            XCTAssertNil(error, "Expected not to return error")
            expectation.fulfill()
            
        })
        
        self.wait(for: [expectation], timeout: 5)
    }
}
