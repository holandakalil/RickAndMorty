//
//  CharactersPresenterTests.swift
//  Rick and MortyTests
//
//  Created by Kalil Holanda on 14/10/20.
//

import XCTest
@testable import Rick_and_Morty

class CharactersPresenterTests: XCTestCase {
    
    var sut: CharactersPresenter!
    var mockCharacterWebService: MockCharacterWebService!

    override func setUp() {
        mockCharacterWebService = MockCharacterWebService()
        sut = CharactersPresenter(webService: mockCharacterWebService)
    }

    override func tearDown() {
        sut = nil
        mockCharacterWebService = nil
    }
    
    func testCharacterPresenter_DidCallGetAllCharacters() {
        // Act
        sut.getAllCharacters()
        
        // Assert
        XCTAssertTrue(mockCharacterWebService.hasCalledGetAllCharacters, "getAllCharacters() method was not called")
    }
    
    func testCharacterPresenter_DidCallGetFavoredCharacters() {
        // Act
        sut.getFavoredCharacters(with: [1])
        
        // Assert
        XCTAssertTrue(mockCharacterWebService.hasCalledGetFavoredCharacters, "getFavoredCharacters() method was not called")
    }
}
