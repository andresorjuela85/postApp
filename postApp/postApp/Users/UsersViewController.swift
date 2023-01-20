//
//  UsersViewController.swift
//  postApp
//
//  Created by Andres Orjuela on 18/01/23.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet weak var usersTableView: UITableView!
    
    let viewModel = UsersViewModel()
    
    var searchController =  UISearchController()
    private var filterViewController: FilterTableViewController!
    private var searchFilterSelected: Int = 0
    
    var navigation: UINavigationBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupSearch()
        setupBindings()
        viewModel.getUsers()
        setupTable()
    }
    
    private func setupTable() {
        usersTableView.dataSource = self
        usersTableView.delegate = self
        usersTableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "reuseCell")
    }
    
    func setupBindings() {
        
        viewModel.loading = { [weak self] isLoading in
            
            if isLoading {
                self?.showLoader()
            } else {
                self?.removeLoader()
            }
        }
        
        viewModel.onGetUser = { [weak self] in
            self?.usersTableView.reloadData()
        }
    }
    
    private func setupSearch() {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        filterViewController = storyBoard.instantiateViewController(withIdentifier: "FilterTableViewController") as? FilterTableViewController
        filterViewController.tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: filterViewController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    
    func filterContentForSearchText(_ searchText: String) {
        
        let isSearchBarEmpty = searchController.searchBar.text?.isEmpty ?? true
        
        if searchFilterSelected == 0 {
            filterViewController.filteredUsers = viewModel.users.filter({ (user) -> Bool in
                if isSearchBarEmpty {
                    return false
                } else {
                    return user.name?.lowercased().contains(searchText.lowercased()) ?? false
                }
            })
        }
        
        filterViewController.tableView.reloadData()
    }
}


extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath) as? UserCell else {
            return UITableViewCell()
        }
        cell.configure(user: viewModel.users[indexPath.row])
        return cell
    }
}

extension UsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedUser = viewModel.users[indexPath.row]
        let postsViewModel = PostsViewModel(user: selectedUser)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PostsViewController") as? PostsViewController {
            nextViewController.viewModel = postsViewModel
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}

extension UsersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchFilterSelected = selectedScope
        filterContentForSearchText(searchBar.text ?? "")
    }
}

extension UsersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text ?? "")
    }
}
