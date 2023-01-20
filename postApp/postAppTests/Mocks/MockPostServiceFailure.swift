//
//  MockPostServiceFailure.swift
//  postAppTests
//
//  Created by Andres Orjuela on 20/01/23.
//

import Foundation
@testable import postApp

class MockPostServiceFailure: PostServiceProtocol {
    
    func getUsers(completion: @escaping (_ result: Result<[UserRemote], NetworkError>) -> Void) {
        completion(.failure(.genericError))
    }
    
    func getPosts(userId: Int, completion: @escaping (_ result: Result<[PostRemote], NetworkError>) -> Void) {
        completion(.failure(.genericError))
    }
}
