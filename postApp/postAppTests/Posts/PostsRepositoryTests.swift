//
//  PostsRepositoryTests.swift
//  postAppTests
//
//  Created by Andres Orjuela on 20/01/23.
//

import XCTest
@testable import postApp

final class PostsRepositoryTests: XCTestCase {

    var sut: PostsRepository!

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testGetPostsFromServiceSuccess() throws {
        
        let database = PostsDataBase()
        database.deleteDatabase()
        
        sut = PostsRepository(database: database, service: MockPostService())
        
        var posts: [Post] = []
        
        let promise = expectation(description: "Posts retrieved from service")
        
        sut.getPosts(userId: 1) { postsResponse in
            posts = postsResponse
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
        
        XCTAssert(posts.count == 4, "getPosts response with user posts")
    }
    
    func testGetPostsFromServiceFailure() throws {
        
        let database = PostsDataBase()
        database.deleteDatabase()
        
        sut = PostsRepository(database: database, service: MockPostServiceFailure())
        
        var posts: [Post] = []
        
        let promise = expectation(description: "Posts retrieved from service")
        
        sut.getPosts(userId: 1) { postsResponse in
            posts = postsResponse
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
        
        XCTAssert(posts.count == 0, "getPosts response with user posts")
    }
    
    func testGetPostsFromDatabase() throws {
        
        sut = PostsRepository(database: MockPostsDataBase())
        
        var posts: [Post] = []
        
        let promise = expectation(description: "Posts retrieved from service")
        
        sut.getPosts(userId: 1) { postsResponse in
            posts = postsResponse
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
        
        XCTAssert(posts.count == 5, "getUsers response with users")
    }
}

