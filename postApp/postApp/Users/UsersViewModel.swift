//
//  UsersViewModel.swift
//  postApp
//
//  Created by Andres Orjuela on 18/01/23.
//

import Foundation

protocol UsersViewModelDelegate {
    
    var users: [User] { get set }
    func getUsers()
}

class UsersViewModel: UsersViewModelDelegate {
    
    var users: [User] = []
    var repository: UsersRepositoryProtocol
    var onGetUser: (() -> Void)?
    var loading: ((Bool) -> Void)?
    
    init(repository: UsersRepositoryProtocol = UsersRepository()) {
        self.repository = repository
    }
    
    func getUsers() {
        
        self.loading?(true)
        
        repository.getUsers { [weak self] users in
            DispatchQueue.main.async {
                self?.loading?(false)
                self?.users = users
                self?.onGetUser?()
            }
        }
    }
}
