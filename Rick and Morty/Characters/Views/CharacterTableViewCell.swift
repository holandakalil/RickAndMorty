//
//  CharacterTableViewCell.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 13/10/20.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    var characterImageView = UIImageView()
    var characterNameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(characterImageView)
        addSubview(characterNameLabel)
        setupCharacterImageView()
        setupCharacterNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(character: CharacterModel) {
        characterNameLabel.text = character.name
        
        guard let url = URL(string: character.image) else { return }
        characterImageView.loadImage(at: url)
    }
    
    func setupCharacterImageView() {
        characterImageView.layer.cornerRadius = 10
        characterImageView.clipsToBounds = true
        characterImageView.contentMode = .scaleAspectFill
        
        let guide = self.safeAreaLayoutGuide
        
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 12).isActive = true
        characterImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        characterImageView.heightAnchor.constraint(equalToConstant: Constants.listRowHeight - 20).isActive = true
        characterImageView.widthAnchor.constraint(equalToConstant: Constants.listRowHeight - 20).isActive = true
    }
    
    func setupCharacterNameLabel() {
        characterNameLabel.numberOfLines = 0
        characterNameLabel.adjustsFontSizeToFitWidth = true
        characterNameLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        characterNameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 12).isActive = true
        characterNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        characterNameLabel.heightAnchor.constraint(equalToConstant: Constants.listRowHeight - 20).isActive = true
        characterNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    // Cancel load image for reuse
    override func prepareForReuse() {
        characterImageView.image = nil
        characterImageView.cancelImageLoad()
    }
}
