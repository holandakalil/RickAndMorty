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
    var mockListCharacterView: MockAllCharacterView!

    override func setUp() {
        mockCharacterWebService = MockCharacterWebService()
        mockListCharacterView = MockAllCharacterView()
        sut = CharactersPresenter(webService: mockCharacterWebService, listCharactersView: mockListCharacterView)
    }

    override func tearDown() {
        sut = nil
        mockCharacterWebService = nil
        mockListCharacterView = nil
    }
    
    func testCharacterPresenter_DidCallGetAllCharacters() {
        // Act
        sut.getAllCharacters()
        
        // Assert
        XCTAssertTrue(mockCharacterWebService.hasCalledGetAllCharacters, "getAllCharacters() method was not called")
    }
    
    func testCharacterPresenter_CallSuccessful_getAllCharacters() {
        // Arrange
        let myExpectation = self.expectation(description: "expected successfulGetList() to be called")
        mockListCharacterView.expectation = myExpectation
        
        // Act
        sut.getAllCharacters()
        self.wait(for: [myExpectation], timeout: 5)
        
        // Assert
        XCTAssertTrue(mockListCharacterView.hasCalledSuccessfulGetList, "hasCalledSuccessfulGetList() method was not called")
        XCTAssertFalse(mockListCharacterView.hasCalledError, "should not call errorGetList()")
    }
    
    func testCharacterPresenter_CallunSuccessful_getAllCharacters() {
        // Arrange
        let myExpectation = self.expectation(description: "expected errorGetList() to be called")
        mockListCharacterView.expectation = myExpectation
        mockCharacterWebService.shouldReturnError = true
        
        // Act
        sut.getAllCharacters()
        self.wait(for: [myExpectation], timeout: 5)
        
        // Assert
        XCTAssertTrue(mockListCharacterView.hasCalledError, "errorGetList() method was not called")
        XCTAssertFalse(mockListCharacterView.hasCalledSuccessfulGetList, "should not call hasCalledSuccessfulGetList()")
    }
}
