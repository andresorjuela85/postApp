//
//  UsersRepository.swift
//  postApp
//
//  Created by Andres Orjuela on 19/01/23.
//

import Foundation

protocol UsersRepositoryProtocol {
    
    func getUsers(completion: @escaping ([User]) -> Void)
}

class UsersRepository: UsersRepositoryProtocol {
    
    var database: PostsDataBaseProtocol
    var service: PostServiceProtocol
    
    init(database: PostsDataBaseProtocol = PostsDataBase(), service: PostServiceProtocol = PostService()) {
        self.database = database
        self.service = service
    }
    
    func getUsers(completion: @escaping ([User]) -> Void) {
        
        let users = database.getUsers()
        if users.count == 0 {
            service.getUsers { [weak self] usersResponse in
                
                switch usersResponse {
                    
                case .success(let user):
                    self?.database.saveUsers(user)
                case .failure(let error):
                    print(error)
                }
                    
                completion(self?.database.getUsers() ?? [])
            }
        } else {
            completion(users)
        }
    }
}
