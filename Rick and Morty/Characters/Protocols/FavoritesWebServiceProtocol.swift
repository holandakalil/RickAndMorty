//
//  FavoritesWebServiceProtocol.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 15/10/20.
//

import Foundation

protocol FavoritesWebServiceProtocol {
    func getFavoritedCharacters(with charactersId: [Int], completionHandler: @escaping ([CharacterModel]?, CharacterError?) -> Void)
}
