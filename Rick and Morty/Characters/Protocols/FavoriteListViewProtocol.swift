//
//  FavoriteListViewProtocol.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 16/10/20.
//

import UIKit

protocol FavoriteListViewProtocol {
    func updateUI()
    func goToDetails(of character: CharacterModel, image: UIImage)
}
