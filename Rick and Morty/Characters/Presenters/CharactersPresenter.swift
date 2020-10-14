//
//  CharactersPresenter.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 14/10/20.
//

import Foundation

class CharactersPresenter {
    
    private var webService: CharacterWebServiceProtocol
    
    init(webService: CharacterWebServiceProtocol) {
        self.webService = webService
    }
    
    func getAllCharacters(at page: Int = 0) {
        webService.getAllCharacters(at: page) { (allCharacters, error) in
            // TODO: -
        }
    }
    
    func getFavoredCharacters(with charactersId: [Int]) {
        webService.getFavoredCharacters(with: charactersId) { (characters, error) in
            // TODO: -
        }
    }
}
