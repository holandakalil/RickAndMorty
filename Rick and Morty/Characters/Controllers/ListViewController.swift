//
//  ListViewController.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 13/10/20.
//

import UIKit

class ListViewController: UIViewController {
    
    struct CellId {
        static let characterCell = "CharacterCellId"
        static let loadingCell = "LoadingCellId"
    }
    
    var listTableView = UITableView()
    var characters: [CharacterModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        title = "Characters"
        // TODO: Fetch data
        // TODO: Setup loading
        // TODO: Setup paging
    }
    
    func setupTableView() {
        view.addSubview(listTableView)
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        listTableView.separatorStyle = .none
        
        listTableView.rowHeight = Constants.listRowHeight
        listTableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CellId.characterCell)
        listTableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: CellId.loadingCell)
        
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        listTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func getAllCharacters() {
//        CharacterWebService.getAllCharacters(CharacterWebService)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId.characterCell, for: indexPath) as! CharacterTableViewCell
        cell.set(character: characters[indexPath.row])
        return cell
    }
}
