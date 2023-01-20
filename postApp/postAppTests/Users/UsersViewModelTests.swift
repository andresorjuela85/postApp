//
//  UsersViewModelTests.swift
//  postAppTests
//
//  Created by Andres Orjuela on 20/01/23.
//

import XCTest
@testable import postApp

final class UsersViewModelTests: XCTestCase {
    
    var sut: UsersViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = UsersViewModel(repository: MockUsersRepository())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testGetUsers() throws {
        
        let promise = expectation(description: "Users retrieved")
        
        let onGetUser = {
            promise.fulfill()
        }
       
        sut.onGetUser = onGetUser
        sut.getUsers()
        
        wait(for: [promise], timeout: 5)
        
        XCTAssert(sut.users.count > 0, "getUsers response with users")
    }
}
