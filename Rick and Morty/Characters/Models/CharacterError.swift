//
//  CharacterError.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 12/10/20.
//

import Foundation

enum CharacterError: LocalizedError, Equatable {
    case invalidResponseModel
    case invalidRequestURLString
    case failedRequest
    
    var errorDescription: String {
        switch self {
        case .failedRequest, .invalidResponseModel, .invalidRequestURLString:
            return "Houve um erro 😰"
        }
    }
}
