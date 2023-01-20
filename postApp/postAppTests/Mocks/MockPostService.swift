//
//  MockPostService.swift
//  postAppTests
//
//  Created by Andres Orjuela on 20/01/23.
//

import Foundation
@testable import postApp

class MockPostService: PostServiceProtocol {
    
    func getUsers(completion: @escaping (_ result: Result<[UserRemote], NetworkError>) -> Void) {
        
        let users: [UserRemote] = [UserRemote(id: 1, name: nil, email: nil, phone: nil),
                                   UserRemote(id: 2, name: nil, email: nil, phone: nil),
                                   UserRemote(id: 3, name: nil, email: nil, phone: nil),
                                   UserRemote(id: 4, name: nil, email: nil, phone: nil)]
        
        completion(.success(users))
    }
    
    func getPosts(userId: Int, completion: @escaping (_ result: Result<[PostRemote], NetworkError>) -> Void) {
     
        let posts: [PostRemote] = [PostRemote(id: 1, userId: 1, title: nil, body: nil),
                                   PostRemote(id: 2, userId: 1, title: nil, body: nil),
                                   PostRemote(id: 3, userId: 1, title: nil, body: nil),
                                   PostRemote(id: 4, userId: 1, title: nil, body: nil)]
        
        completion(.success(posts))
    }
}
