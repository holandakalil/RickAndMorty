//
//  Mock.swift
//  Rick and MortyTests
//
//  Created by Kalil Holanda on 15/10/20.
//

import Foundation
@testable import Rick_and_Morty

class MockListCharacterView: AllCharactersViewProtocol {
    
    var hasCalledUpdateUI = false
    var hasCalledFavoriteCharacter = false
    var hasCalledGoToFavorites = false
    
    func updateUI() {
        hasCalledUpdateUI = true
    }
    
    func favoriteCharacter(with characterId: Int) {
        hasCalledFavoriteCharacter = true
    }
    
    func goToFavorites() {
        hasCalledGoToFavorites = true
    }
}
