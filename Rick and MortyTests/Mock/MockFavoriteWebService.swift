//
//  MockFavoriteWebService.swift
//  Rick and MortyTests
//
//  Created by Kalil Holanda on 16/10/20.
//

import Foundation
@testable import Rick_and_Morty

class MockFavoriteWebService: FavoritesWebServiceProtocol {
    
    var hasCalledGetFavoritedCharacters = false
    var shouldReturnError = false
    
    func getFavoritedCharacters(with charactersId: [Int], completionHandler: @escaping ([CharacterModel]?, CharacterError?) -> Void) {
        hasCalledGetFavoritedCharacters = true
        if shouldReturnError {
            completionHandler(nil, .failedRequest)
        } else {
            let response = CharacterModel(id: 0, name: "", status: "", species: "", type: "", gender: "", origin: .init(name: "", url: ""), location: .init(name: "", url: ""), image: "", episode: [], url: "")
            completionHandler([response], nil)
        }
    }
}
