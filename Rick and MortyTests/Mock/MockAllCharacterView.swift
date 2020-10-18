//
//  Mock.swift
//  Rick and MortyTests
//
//  Created by Kalil Holanda on 15/10/20.
//

import UIKit
import XCTest
@testable import Rick_and_Morty

class MockAllCharacterView: AllCharactersViewProtocol {
    
    var expectation: XCTestExpectation?
    var errorMessage: String?
    
    var hasCalledSuccessfulGetList = false
    var hasCalledError = false
    var hasCalledGoToFavorites = false
    var hasCalledGoToDetails = false
    var hasCalledFavoriteCharacter = false
    var hasCalledUnfavoriteCharacter = false
    
    func successfulGetList() {
        hasCalledSuccessfulGetList = true
        expectation?.fulfill()
    }
    
    func errorGetList(withMessage message: String) {
        hasCalledError = true
        errorMessage = message
        expectation?.fulfill()
    }
    
    func goToFavoritesCharacterViewController() {
        hasCalledGoToFavorites = true
    }
    
    func goToDetails(of character: CharacterModel, image: UIImage?) {
        hasCalledGoToDetails = true
    }
    
    func favoriteCharacter(with characterId: Int) {
        hasCalledFavoriteCharacter = true
    }
    
    func unfavoriteCharacter(with characterId: Int) {
        hasCalledUnfavoriteCharacter = true
    }
}
