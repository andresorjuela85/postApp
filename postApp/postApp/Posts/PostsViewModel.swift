//
//  PostsViewModel.swift
//  postApp
//
//  Created by Andres Orjuela on 18/01/23.
//

import Foundation

protocol PostsViewModelDelegate {
    
    var user: User { get set }
    var posts: [Post] { get set }
    func getPosts()
}

class PostsViewModel: PostsViewModelDelegate {
    
    var user: User
    var posts: [Post] = []
    var repository: PostsRepositoryProtocol
    var onGetPost: (() -> Void)?
    var loading: ((Bool) -> Void)?
    
    init(user: User, repository: PostsRepositoryProtocol = PostsRepository()) {
        self.user = user
        self.repository = repository
    }
    
    func getPosts() {
        
        self.loading?(true)
        
        repository.getPosts(userId: user.id) { [weak self] post in
            DispatchQueue.main.async {
                self?.loading?(false)
                self?.posts = post
                self?.onGetPost?()
            }
        }
    }
}
