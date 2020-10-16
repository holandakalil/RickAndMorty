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
    
    func testCharacterPresenter_DidCallListCharacterViewMethods() {
        // Act
        mockListCharacterView.updateUI()
        mockListCharacterView.goToFavorites()
        mockListCharacterView.goToDetails(of: CharacterModel(id: 0, name: "", status: "", species: "", type: "", gender: "", origin: .init(name: "", url: ""), location: .init(name: "", url: ""), image: "", episode: [], url: ""), image: UIImage())
        mockListCharacterView.favoriteCharacter(with: 0)
        mockListCharacterView.unfavoriteCharacter(with: 0)
        
        // Assert
        XCTAssertTrue(mockListCharacterView.hasCalledUpdateUI, "updateUI() method was not called")
        XCTAssertTrue(mockListCharacterView.hasCalledGoToFavorites, "goToFavorites() method was not called")
        XCTAssertTrue(mockListCharacterView.hasCalledGoToDetails, "goToDetails() method was not called")
        XCTAssertTrue(mockListCharacterView.hasCalledFavoriteCharacter, "favoriteCharacter() method was not called")
        XCTAssertTrue(mockListCharacterView.hasCalledUnfavoriteCharacter, "unfavoriteCharacter() method was not called")
    }
}
