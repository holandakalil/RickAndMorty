//
//  ViewCodeProtocol.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 18/10/20.
//

import Foundation

protocol ViewCodeProtocol {
    func buildHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewCodeProtocol {
    func applyViewCode() {
        buildHierarchy()
        setupConstraints()
        configureViews()
    }
}
