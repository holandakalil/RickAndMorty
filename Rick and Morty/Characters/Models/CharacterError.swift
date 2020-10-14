//
//  CharacterError.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 12/10/20.
//

import Foundation

enum CharacterError: LocalizedError, CustomNSError, Equatable {
    
    case invalidResponseModel
    case invalidRequestURLString
    case failedRequest(description: String)
    
    var errorDescription: String? {
        switch self {
        case .failedRequest(let description):
            return description
        case .invalidResponseModel, .invalidRequestURLString:
            return ""
        }
    }
}
