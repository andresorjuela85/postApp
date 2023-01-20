//
//  MockPostsRepository.swift
//  postAppTests
//
//  Created by Andres Orjuela on 20/01/23.
//

import Foundation
@testable import postApp

class MockPostsRepository: PostsRepositoryProtocol {
    
    func getPosts(userId: Int, completion: @escaping ([Post]) -> Void) {
        
        let posts: [Post] = [Post(),
                             Post(),
                             Post(),
                             Post(),
                             Post()]
        
        completion(posts)
    }
}
