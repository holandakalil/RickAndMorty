//
//  GetAllCharactersProtocol.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 14/10/20.
//

import Foundation

protocol AllCharactersViewProtocol {
    func updateUI()
    func favoriteCharacter(with characterId: Int)
    func goToFavorites()
}
