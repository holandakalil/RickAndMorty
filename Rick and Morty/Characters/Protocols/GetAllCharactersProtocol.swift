//
//  GetAllCharactersProtocol.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 14/10/20.
//

import Foundation

protocol GetAllCharactersProtocol {
    func getAllCharacters(at page: Int, completionHandler: @escaping (AllCharactersResponseModel?, CharacterError?) -> Void)
}
