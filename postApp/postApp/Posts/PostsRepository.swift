//
//  PostsRepository.swift
//  postApp
//
//  Created by Andres Orjuela on 20/01/23.
//

import Foundation

protocol PostsRepositoryProtocol {
    
    func getPosts(userId: Int, completion: @escaping ([Post]) -> Void)
}

class PostsRepository: PostsRepositoryProtocol {
    
    var database: PostsDataBaseProtocol
    var service: PostServiceProtocol
    
    init(database: PostsDataBaseProtocol = PostsDataBase(), service: PostServiceProtocol = PostService()) {
        self.database = database
        self.service = service
    }
    
    func getPosts(userId: Int, completion: @escaping ([Post]) -> Void) {
        
        let posts = database.getPosts(userId: userId)
        if posts.count == 0 {
            service.getPosts(userId: userId) { [weak self] postsResponse in
                
                switch postsResponse {
                    
                case .success(let post):
                    self?.database.savePosts(post)
                case .failure(let error):
                    print(error)
                }

                completion(self?.database.getPosts(userId: userId) ?? [])
            }
        } else {
            completion(posts)
        }
    }
}
