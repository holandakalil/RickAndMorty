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
    
    func getFavoritedCharacters(with charactersId: [Int], completionHandler: @escaping ([CharacterModel]?, CharacterError?) -> Void) {
        hasCalledGetFavoritedCharacters = true
    }
}
