//
//  FavoritesPresenter.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 15/10/20.
//

import Foundation

class FavoritesPresenter {
    
    private var webService: FavoritesWebServiceProtocol
    private var listFavoritesView: FavoriteListViewProtocol
    
    var characters: [CharacterModel] = []
    
    init(webService: FavoritesWebServiceProtocol = FavoriteWebService(), listFavoritesView: FavoriteListViewProtocol) {
        self.webService = webService
        self.listFavoritesView = listFavoritesView
    }
    
    // MARK: - WebService
    func getFavoritedCharacters() {
        let charactersId = Favorites.shared.getFavoritesId()
        webService.getFavoritedCharacters(with: charactersId) { (characters, error) in
            
            // TODO: - Handle error
            if let favCharacters = characters {
                self.characters = favCharacters
                DispatchQueue.main.async {
                    self.listFavoritesView.updateUI()
                }
            }
        }
    }
}

