//
//  AllCharactersViewController.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 13/10/20.
//

import UIKit

class AllCharactersViewController: UIViewController {
    
    struct CellId {
        static let characterCell = "CharacterCellId"
    }
    
    lazy var charactersPresenter = CharactersPresenter(listCharactersView: self)
    var listTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
        charactersPresenter.getAllCharacters()
        charactersPresenter.getFavoredCharacters(with: [1,4,6])
        // TODO: Setup favorites
    }
    
    func setupNavBar() {
        title = "Characters"
        
        let favoritesButton = UIBarButtonItem(image: UIImage(systemName: "star.fill"),
                                              style: .plain,
                                              target: self,
                                              action: #selector(goToFavorites))
        favoritesButton.tintColor = .purple
        navigationItem.rightBarButtonItem = favoritesButton
    }
    
    func setupTableView() {
        view.addSubview(listTableView)
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        listTableView.separatorStyle = .none
        
        listTableView.rowHeight = Constants.listRowHeight
        listTableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CellId.characterCell)
        
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        listTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

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
        //TODO: go to details
    }
}

extension AllCharactersViewController: AllCharactersViewProtocol {
    func updateUI() {
        self.listTableView.tableFooterView = charactersPresenter.isLastPage ? UIView() : LoadingTableViewFooter(frame: listTableView.frame)
        self.listTableView.reloadData()
    }
    
    @objc func goToFavorites() {
        // TODO
    }
    
    func favoriteCharacter(with characterId: Int) {
        // TODO
    }
}
