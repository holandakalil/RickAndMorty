//
//  MockFavoritesView.swift
//  Rick and MortyTests
//
//  Created by Kalil Holanda on 16/10/20.
//

import UIKit
import XCTest
@testable import Rick_and_Morty

class MockFavoritesListView: FavoriteListViewProtocol {
    
    var expectation: XCTestExpectation?
    var errorMessage: String?
    
    var hasCalledSuccess = false
    var hasCalledError = false
    var hasCalledGoToDetails = false
    
    func successfulGetList() {
        hasCalledSuccess = true
        expectation?.fulfill()
    }
    
    func errorGetList(withMessage message: String) {
        hasCalledError = true
        errorMessage = message
        expectation?.fulfill()
    }
    
    func goToDetails(of character: CharacterModel, image: UIImage?) {
        hasCalledGoToDetails = true
    }
    
}
