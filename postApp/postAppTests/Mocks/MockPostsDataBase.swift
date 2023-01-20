//
//  MockPostsDataBase.swift
//  postAppTests
//
//  Created by Andres Orjuela on 20/01/23.
//

import Foundation
@testable import postApp

class MockPostsDataBase: PostsDataBaseProtocol {
    
    func saveUsers(_ users: [UserRemote]) {
        
    }
    
    func getUsers() -> [User] {
        return [User(),
                User(),
                User(),
                User(),
                User()]
    }
    
    func getPosts(userId: Int) -> [Post] {
        return [Post(),
                Post(),
                Post(),
                Post(),
                Post()]
    }
    
    func savePosts(_ posts: [PostRemote]) {
        
    }
}
