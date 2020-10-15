//
//  CharactersPresenter.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 14/10/20.
//

import Foundation

class CharactersPresenter {
    
    private var webService: CharacterWebServiceProtocol
    private var listCharactersView: AllCharactersViewProtocol
    
    private var page = 1
    private var isLoading = false
    
    var characters: [CharacterModel] = []
    var isLastPage = false
    
    init(webService: CharacterWebServiceProtocol = CharacterWebService(), listCharactersView: AllCharactersViewProtocol) {
        self.webService = webService
        self.listCharactersView = listCharactersView
    }
    
    func getAllCharacters() {
        if isLoading {
            return
        }
        
        isLoading = true
        webService.getCharacters(at: page) { (response, error) in
            print("getPage: \(self.page)")
            // TODO: - Handle error
            if let allCharacters = response {
                if allCharacters.results.count == 0 {
                    self.isLastPage = true
                } else {
                    self.characters.append(contentsOf: allCharacters.results)
                }
                DispatchQueue.main.async {
                    self.listCharactersView.updateUI()
                }
            }
            self.isLoading = false
            self.page += 1
        }
    }
    
    func getFavoredCharacters(with charactersId: [Int]) {
        webService.getFavoredCharacters(with: charactersId) { (characters, error) in
            // TODO: -
        }
    }
}

