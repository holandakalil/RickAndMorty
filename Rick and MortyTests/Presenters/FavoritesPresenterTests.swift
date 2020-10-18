//
//  FavoritesPresenterTests.swift
//  Rick and MortyTests
//
//  Created by Kalil Holanda on 16/10/20.
//

import XCTest
@testable import Rick_and_Morty

class FavoritesPresenterTests: XCTestCase {
    
    var sut: FavoritesPresenter!
    var mockFavoritesWebService: MockFavoriteWebService!
    var mockFavoritesListView: MockFavoritesListView!

    override func setUp() {
        mockFavoritesWebService = MockFavoriteWebService()
        mockFavoritesListView = MockFavoritesListView()
        sut = FavoritesPresenter(webService: mockFavoritesWebService, listFavoritesView: mockFavoritesListView)
    }

    override func tearDown() {
        sut = nil
        mockFavoritesWebService = nil
        mockFavoritesListView = nil
    }
    
    func testFavoritesPresenter_DidCallGetFavoritesCharacters() {
        // Act
        sut.getFavoritedCharacters()
        
        // Assert
        XCTAssertTrue(mockFavoritesWebService.hasCalledGetFavoritedCharacters, "hasCalledGetFavoritedCharacters() method was not called")
    }
    
    func testFavoritesPresenter_CallSuccessful_getFavoritedCharacters() {
        // Arrange
        let myExpectation = self.expectation(description: "expected successfulGetList() to be called")
        mockFavoritesListView.expectation = myExpectation
        
        // Act
        sut.getFavoritedCharacters()
        self.wait(for: [myExpectation], timeout: 5)
        
        // Assert
        XCTAssertTrue(mockFavoritesListView.hasCalledSuccess, "successfulGetList() method was not called")
        XCTAssertFalse(mockFavoritesListView.hasCalledError, "should not call errorGetList()")
    }
    
    func testFavoritesPresenter_CallunSuccessful_getFavoritedCharacters() {
        // Arrange
        let myExpectation = self.expectation(description: "expected errorGetList() to be called")
        mockFavoritesListView.expectation = myExpectation
        mockFavoritesWebService.shouldReturnError = true
        
        // Act
        sut.getFavoritedCharacters()
        self.wait(for: [myExpectation], timeout: 5)
        
        // Assert
        XCTAssertTrue(mockFavoritesListView.hasCalledError, "errorGetList() method was not called")
        XCTAssertFalse(mockFavoritesListView.hasCalledSuccess, "should not call successfulGetList()")
    }
}
