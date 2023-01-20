//
//  PostsViewModelTests.swift
//  postAppTests
//
//  Created by Andres Orjuela on 20/01/23.
//

import XCTest
@testable import postApp

final class PostsViewModelTests: XCTestCase {
    
    var sut: PostsViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = PostsViewModel(user: User(), repository: MockPostsRepository())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testGetPosts() throws {
        
        let promise = expectation(description: "Posts retrieved")
        
        let onGetPost = {
            promise.fulfill()
        }
       
        sut.onGetPost = onGetPost
        sut.getPosts()
        
        wait(for: [promise], timeout: 5)
        
        XCTAssert(sut.posts.count > 0, "getPosts response with user posts")
    }
}
