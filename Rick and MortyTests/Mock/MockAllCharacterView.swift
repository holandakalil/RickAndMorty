//
//  Mock.swift
//  Rick and MortyTests
//
//  Created by Kalil Holanda on 15/10/20.
//

import UIKit
@testable import Rick_and_Morty

class MockAllCharacterView: AllCharactersViewProtocol {
    
    var hasCalledUpdateUI = false
    var hasCalledGoToFavorites = false
    var hasCalledGoToDetails = false
    var hasCalledFavoriteCharacter = false
    var hasCalledUnfavoriteCharacter = false
    
    func updateUI() {
        hasCalledUpdateUI = true
    }
    
    func goToFavorites() {
        hasCalledGoToFavorites = true
    }
    
    func goToDetails(of character: CharacterModel, image: UIImage) {
        hasCalledGoToDetails = true
    }
    
    func favoriteCharacter(with characterId: Int) {
        hasCalledFavoriteCharacter = true
    }
    
    func unfavoriteCharacter(with characterId: Int) {
        hasCalledUnfavoriteCharacter = true
    }
}
