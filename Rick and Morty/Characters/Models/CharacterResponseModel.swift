//
//  CharacterModel.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 12/10/20.
//

import Foundation

// Get all characters response model
struct AllCharactersResponseModel: Decodable {
    let info: ResponseInfo
    let results: [CharacterModel]
    
    struct ResponseInfo: Decodable {
        let count: Int
        let pages: Int
        let next: String
        let prev: String
    }
}
