//
//  MockUsersRepository.swift
//  postAppTests
//
//  Created by Andres Orjuela on 20/01/23.
//

import Foundation
@testable import postApp

class MockUsersRepository: UsersRepositoryProtocol {
    
    func getUsers(completion: @escaping ([User]) -> Void) {
        
        let users: [User] = [User(),
                             User(),
                             User(),
                             User(),
                             User()]
        
        completion(users)
    }
}
