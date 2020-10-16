//
//  AllCharactersViewProtocol.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 14/10/20.
//

import UIKit

protocol AllCharactersViewProtocol: FavoriteCharacterProtocol {
    func updateUI()
    func goToFavorites()
    func goToDetails(of character: CharacterModel, image: UIImage)
}
