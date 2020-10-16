//
//  CharacterDetailViewController.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 15/10/20.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    var character: CharacterModel?
    var characterImage: UIImage?
    
    private var favoriteButton = UIBarButtonItem()
    
    private lazy var charImage: UIImageView = {
        let iv = UIImageView()
        iv.image = characterImage
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    private lazy var charNameLabel: UILabel = {
        let label = UILabel()
        label.text = character?.name
        label.textColor = .darkGray
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var charOriginLabel: UILabel = {
        let label = UILabel()
        label.text = character?.origin.name
        label.textColor = .darkGray
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var charDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "\(character!.species), \(character!.gender) \(character!.type), location: \(character!.location.name), status: \(character!.status)"
        label.textColor = .black
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    private lazy var guide = view.safeAreaLayoutGuide
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let _ = character else {
            self.title = "Error..." // TODO: -
            return
        }
        setupUI()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        view.updateConstraintsIfNeeded() // TODO
    }
    
    // MARK: - Setup UI
    func setupUI() {
        view.backgroundColor = UIColor(named: "VCBackgroundColor")
        setupNavBar()
        
        view.addSubview(charImage)
        view.addSubview(charNameLabel)
        view.addSubview(charOriginLabel)
        view.addSubview(charDescriptionLabel)
        
        setupViews()
    }
    
    func setupNavBar() {
        guard let character = character else { return }
        title = character.status
        let isFavorited = Favorites.shared.isFavorite(character.id)
        
        favoriteButton = UIBarButtonItem(image: isFavorited ? Constants.FavoriteImage.favorited : Constants.FavoriteImage.unfavorited,
                                         style: .plain,
                                         target: self,
                                         action: #selector(favoriteButtonAction))
        favoriteButton.tintColor = .purple
        navigationController?.navigationBar.tintColor = .purple
        navigationController?.navigationBar.backgroundColor = nil
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    func setupViews() {
        setupCharImage()
        setupNameLabel()
        setupOriginLabel()
        setupDescriptionLabel()
    }
    
    func setupCharImage(isLandscape: Bool = false) {
        for c in charImage.constraints {
            c.isActive = false
        }
        
        let charImageSideConstant: CGFloat = view.frame.height / 4
        charImage.widthAnchor.constraint(equalToConstant: charImageSideConstant).isActive = true
        charImage.heightAnchor.constraint(equalToConstant: charImageSideConstant).isActive = true

        charImage.topAnchor.constraint(equalTo: guide.topAnchor, constant:  15).isActive = true
        charImage.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
    }
    
    func setupNameLabel() {
        charNameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        charNameLabel.topAnchor.constraint(equalTo: charImage.bottomAnchor, constant: 15).isActive = true
        charNameLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 12).isActive = true
        charNameLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -12).isActive = true
    }
    
    func setupOriginLabel() {
        charOriginLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        charOriginLabel.topAnchor.constraint(equalTo: charNameLabel.bottomAnchor, constant: 15).isActive = true
        charOriginLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 12).isActive = true
        charOriginLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -12).isActive = true
    }
    
    func setupDescriptionLabel() {
        charDescriptionLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        charDescriptionLabel.topAnchor.constraint(equalTo: charOriginLabel.bottomAnchor, constant: 15).isActive = true
        charDescriptionLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 12).isActive = true
        charDescriptionLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -12).isActive = true
    }
    
    // MARK: - Update layout with orientation
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        DispatchQueue.main.async {
            self.setupViews()
        }
    }
    
    // MARK: - Bar button Action
    @objc func favoriteButtonAction() {
        guard let characterId = character?.id else { return }
        let isFavorited = Favorites.shared.isFavorite(characterId)
        isFavorited ? unfavoriteCharacter(with: characterId) : favoriteCharacter(with: characterId)
    }
}

// MARK: - FavoriteCharacterProtocol
extension CharacterDetailViewController: FavoriteCharacterProtocol {
    func favoriteCharacter(with characterId: Int) {
        Favorites.shared.addFavorite(with: characterId)
        favoriteButton.image = Constants.FavoriteImage.favorited
    }
    
    func unfavoriteCharacter(with characterId: Int) {
        Favorites.shared.removeFavorite(with: characterId)
        favoriteButton.image = Constants.FavoriteImage.unfavorited
    }
}
