//
//  Constants.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 12/10/20.
//

import UIKit

struct Constants {
    static let characterUrl = "https://rickandmortyapi.com/api/character/"
    
    static let listRowHeight: CGFloat = 100
    
    struct FavoriteImage {
        static let favorited = UIImage(systemName: "star.fill")
        static let unfavorited = UIImage(systemName: "star")
        static let list = UIImage(systemName: "list.star")
    }
}

struct CellId {
    static let characterCell = "CharacterCellId"
}
