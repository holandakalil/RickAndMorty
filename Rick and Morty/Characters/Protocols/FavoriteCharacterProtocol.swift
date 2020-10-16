//
//  FavoriteCharacterViewProtocol.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 15/10/20.
//

import UIKit

protocol FavoriteCharacterProtocol {
    func favoriteCharacter(with characterId: Int)
    func unfavoriteCharacter(with characterId: Int)
}
