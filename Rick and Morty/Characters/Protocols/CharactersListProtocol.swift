//
//  CharactersListProtocol.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 18/10/20.
//

import UIKit

protocol CharactersListProtocol {
    func successfulGetList()
    func errorGetList(withMessage message: String)
    func goToDetails(of character: CharacterModel, image: UIImage?)
}
