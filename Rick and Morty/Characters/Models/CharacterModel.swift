//
//  CharacterModel.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 12/10/20.
//

import Foundation

struct CharacterModel: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    
    struct Origin: Decodable {
        let name: String
        let url: String
    }

    struct Location: Decodable {
        let name: String
        let url: String
    }
}
