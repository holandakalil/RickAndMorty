//
//  CharacterWebServiceProtocol.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 12/10/20.
//

import Foundation

protocol CharacterWebServiceProtocol {
    func getCharacters(at page: Int, completionHandler: @escaping (AllCharactersResponseModel?, CharacterError?) -> Void)
    func getFavoredCharacters(with charactersId: [Int], completionHandler: @escaping ([CharacterModel]?, CharacterError?) -> Void)
}
