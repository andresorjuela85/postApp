//
//  UsersRepositoryTests.swift
//  postAppTests
//
//  Created by Andres Orjuela on 20/01/23.
//

import XCTest
@testable import postApp

final class UsersRepositoryTests: XCTestCase {

    var sut: UsersRepository!

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testGetUsersFromServiceSuccess() throws {
        
        let database = PostsDataBase()
        database.deleteDatabase()
        
        sut = UsersRepository(database: database, service: MockPostService())
        
        var users: [User] = []
        
        let promise = expectation(description: "Users retrieved from service")
        
        sut.getUsers { usersResponse in
            users = usersResponse
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
        
        XCTAssert(users.count == 4, "getUsers response with users")
    }
    
    func testGetUsersFromServiceFailure() throws {
        
        let database = PostsDataBase()
        database.deleteDatabase()
        
        sut = UsersRepository(database: database, service: MockPostServiceFailure())
        
        var users: [User] = []
        
        let promise = expectation(description: "Users not retrieved from service")
        
        sut.getUsers { usersResponse in
            users = usersResponse
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
        
        XCTAssert(users.count == 0, "getUsers response with no users")
    }
    
    func testGetUsersFromDatabase() throws {
        
        sut = UsersRepository(database: MockPostsDataBase())
        
        var users: [User] = []
        
        let promise = expectation(description: "Users retrieved from database")
        
        sut.getUsers { usersResponse in
            users = usersResponse
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
        
        XCTAssert(users.count == 5, "getUsers response with users")
    }
}
