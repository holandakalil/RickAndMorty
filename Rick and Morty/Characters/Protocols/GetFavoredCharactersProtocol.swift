//
//  GetFavoredCharactersProtocol.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 14/10/20.
//

import Foundation

protocol GetFavoredCharactersProtocol {
    func getFavoredCharacters(with charactersId: [Int], completionHandler: @escaping ([CharacterModel]?, CharacterError?) -> Void)
}
