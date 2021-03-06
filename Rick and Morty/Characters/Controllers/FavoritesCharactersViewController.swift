//
//  FavoritesCharactersViewController.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 15/10/20.
//

import UIKit

class FavoritesCharactersViewController: UIViewController {
    
    lazy var favoritesPresenter = FavoritesPresenter(listFavoritesView: self)
    private var listTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        setupNavBar()
        applyViewCode()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Favorites.shared.getFavoritesId().isEmpty {
            navigationController?.popViewController(animated: true)
        } else {
            favoritesPresenter.getFavoritedCharacters()
        }
    }
    
    // MARK: - Setup NavBar
    func setupNavBar() {
        title = "Favorites"
        navigationController?.navigationBar.tintColor = .purple
    }
}

// MARK: - ViewCode
extension FavoritesCharactersViewController: ViewCodeProtocol {
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
        self.listTableView.tableFooterView = LoadingTableViewFooter(frame: listTableView.frame)
        listTableView.separatorStyle = .none
        listTableView.rowHeight = Constants.listRowHeight
        listTableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CellId.characterCell)
    }
}

// MARK: - TableView
extension FavoritesCharactersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesPresenter.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId.characterCell, for: indexPath) as! CharacterTableViewCell
        cell.set(character: favoritesPresenter.characters[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! CharacterTableViewCell
        goToDetails(of: favoritesPresenter.characters[indexPath.row], image: cell.characterImageView.image!)
    }
}

// MARK: - AllCharactersViewProtocol
extension FavoritesCharactersViewController: FavoriteListViewProtocol {
    func successfulGetList() {
        self.listTableView.tableFooterView = UIView()
        self.listTableView.reloadData()
    }
    
    func errorGetList(withMessage message: String) {
        AlertService.alert(in: self, title: "Ops!", message: message, actionTitle: "Tentar novamente") {
            self.favoritesPresenter.getFavoritedCharacters()
        }
    }
    
    func goToDetails(of character: CharacterModel, image: UIImage?) {
        let detailsViewController = CharacterDetailViewController()
        detailsViewController.character = character
        detailsViewController.characterImage = image
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
