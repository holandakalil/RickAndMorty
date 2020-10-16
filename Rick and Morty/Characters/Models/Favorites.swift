//
//  FavoritesModel.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 16/10/20.
//

import Foundation

class Favorites {  // TODO: - Persistence
    static let shared = Favorites()

    private init() { }
    
    private var favoritesId: [Int] = []
    
    func getFavoritesId() -> [Int] {
        return favoritesId
    }
    
    func addFavorite(with id: Int) {
        favoritesId.append(id)
    }
    
    func removeFavorite(with id: Int) {
        favoritesId = favoritesId.filter { $0 != id }
    }
    
    func isFavorite(_ id: Int) -> Bool {
        return favoritesId.contains(id)
    }
}
