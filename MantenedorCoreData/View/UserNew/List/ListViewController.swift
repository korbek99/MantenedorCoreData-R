//
//  ListViewController.swift
//  MantenedorCoreData
//
//  Created by Jose David Bustos H on 08-04-18.
//  Copyright © 2018 Jose David Bustos H. All rights reserved.
//
import UIKit
import CoreData

class ListViewController: UITableViewController, UISearchResultsUpdating {
    

    private var router: MantenedorVMRouter?
    private var coreDataViewModel = CoreDataViewModel()
    private var users: [UserModel] = []
    private var filteredUsers: [UserModel] = []
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let noDataLabel: UILabel = {
        let label = UILabel()
        label.text = "No hay datos aún"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List"
        router = MantenedorVMRouter()
        router?.viewController = self
        setupSearch()
        setupUI()
        loadUsers()
        NotificationCenter.default.addObserver(self, selector: #selector(handleUserUpdate), name: .userDidUpdate, object: nil)
        setupNavigationBar()
        disableBackButton()
    }
    
    private func disableBackButton() {
        let emptyButton = UIBarButtonItem(customView: UIView())
        navigationItem.leftBarButtonItem = emptyButton
    }
    
    @objc private func handleUserUpdate() {
            loadUsers()
    }
    
    private func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Users"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupUI() {
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        tableView.rowHeight = 140.0
        tableView.separatorColor = UIColor.orange
        tableView.backgroundView = noDataLabel
        updateNoDataLabel()
    }
    
    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addButtonTapped() {
        router?.goToCreateUser()
    }
    
    private func loadUsers() {
        users = coreDataViewModel.fetchUsers()
        filteredUsers = users
        updateNoDataLabel()
        tableView.reloadData()
    }
    
    private func deleteUser(at indexPath: IndexPath) {
        let userToDelete = filteredUsers[indexPath.row]
        coreDataViewModel.deleteUser(uuid: userToDelete.ide)
        users.removeAll { $0.ide == userToDelete.ide }
        filteredUsers.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        updateNoDataLabel()
    }
    
    private func updateNoDataLabel() {
        if filteredUsers.isEmpty {
            tableView.backgroundView = noDataLabel
        } else {
            tableView.backgroundView = nil
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            filteredUsers = users
            tableView.reloadData()
            updateNoDataLabel()
            return
        }
        
        filteredUsers = users.filter { user in
            return user.nombre.lowercased().contains(searchText.lowercased()) ||
                   user.apellido.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
        updateNoDataLabel()
    }
}

extension ListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        let user = filteredUsers[indexPath.row]
        cell.nombreLabel.text = user.nombre
        cell.apellidoLabel.text = user.apellido
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = filteredUsers[indexPath.row]
        router?.goToUpdateUser(users: user)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteUser(at: indexPath)
        }
    }
}
extension Notification.Name {
    static let userDidUpdate = Notification.Name("userDidUpdate")
}

