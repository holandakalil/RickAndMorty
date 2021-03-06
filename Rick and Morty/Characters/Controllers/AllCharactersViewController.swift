//
//  AllCharactersViewController.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 13/10/20.
//

import UIKit

class AllCharactersViewController: UIViewController {
    
    lazy var charactersPresenter = CharactersPresenter(listCharactersView: self)
    private var listTableView = UITableView()
    private var favoritesButton = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        setupNavBar()
        applyViewCode()
        charactersPresenter.getAllCharacters()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        favoritesButton.isEnabled = !Favorites.shared.getFavoritesId().isEmpty
    }
    
    // MARK: - Setup NavBar
    func setupNavBar() {
        title = "Characters"
        favoritesButton = UIBarButtonItem(image: Constants.FavoriteImage.list,
                                              style: .plain,
                                              target: self,
                                              action: #selector(goToFavoritesCharacterViewController))
        favoritesButton.tintColor = .purple
        navigationItem.rightBarButtonItem = favoritesButton
    }
}

// MARK: - ViewCode
extension AllCharactersViewController: ViewCodeProtocol {
    func buildHierarchy() {
        view.addSubview(listTableView)
    }
    
    func setupConstraints() {
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        listTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureViews() {
        listTableView.separatorStyle = .none
        listTableView.rowHeight = Constants.listRowHeight
        listTableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CellId.characterCell)
    }
}

// MARK: - TableView
extension AllCharactersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersPresenter.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !charactersPresenter.isLastPage && indexPath.row == charactersPresenter.characters.count - 1 {
            charactersPresenter.getAllCharacters()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId.characterCell, for: indexPath) as! CharacterTableViewCell
        cell.set(character: charactersPresenter.characters[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! CharacterTableViewCell
        goToDetails(of: charactersPresenter.characters[indexPath.row], image: cell.characterImageView.image)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let characterId = self.charactersPresenter.characters[indexPath.row].id
        let isFavorited = Favorites.shared.isFavorite(characterId)
        
        let favAction = UIContextualAction(style: .normal, title: "") { (_, _, completionHandler) in
            isFavorited ? self.unfavoriteCharacter(with: characterId) : self.favoriteCharacter(with: characterId)
            completionHandler(true)
        }
        
        favAction.backgroundColor = .purple
        favAction.image = isFavorited ? Constants.FavoriteImage.favorited : Constants.FavoriteImage.unfavorited
        
        return UISwipeActionsConfiguration(actions: [favAction])
    }
}

// MARK: - AllCharactersViewProtocol
extension AllCharactersViewController: AllCharactersViewProtocol {
    func successfulGetList() {
        self.listTableView.tableFooterView = charactersPresenter.isLastPage ? UIView() : LoadingTableViewFooter(frame: listTableView.frame)
        self.listTableView.reloadData()
    }
    
    func errorGetList(withMessage message: String) {
        AlertService.alert(in: self, title: "Ops!", message: message, actionTitle: "Tentar novamente") {
            self.charactersPresenter.getAllCharacters()
        }
    }
    
    @objc func goToFavoritesCharacterViewController() {
        let favoritesViewController = FavoritesCharactersViewController()
        navigationController?.pushViewController(favoritesViewController, animated: true)
    }
    
    func goToDetails(of character: CharacterModel, image: UIImage?) {
        let detailsViewController = CharacterDetailViewController()
        detailsViewController.character = character
        detailsViewController.characterImage = image
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func favoriteCharacter(with characterId: Int) {
        Favorites.shared.addFavorite(with: characterId)
        favoritesButton.isEnabled = true
    }
    
    func unfavoriteCharacter(with characterId: Int) {
        Favorites.shared.removeFavorite(with: characterId)
        if Favorites.shared.getFavoritesId().isEmpty {
            favoritesButton.isEnabled = false
        }
    }
}
