//
//  MockCharacterWebService.swift
//  Rick and MortyTests
//
//  Created by Kalil Holanda on 14/10/20.
//

import Foundation
@testable import Rick_and_Morty

class MockCharacterWebService: CharacterWebServiceProtocol {
    
    var hasCalledGetAllCharacters = false
    var hasCalledGetFavoredCharacters = false
    
    func getCharacters(at page: Int, completionHandler: @escaping (AllCharactersResponseModel?, CharacterError?) -> Void) {
        hasCalledGetAllCharacters = true
    }
    
    func getFavoredCharacters(with charactersId: [Int], completionHandler: @escaping ([CharacterModel]?, CharacterError?) -> Void) {
        hasCalledGetFavoredCharacters = true
    }
}
