//
//  PostService.swift
//  postApp
//
//  Created by Andres Orjuela on 18/01/23.
//

import Foundation
import Alamofire

protocol PostServiceProtocol {
    
    func getUsers(completion: @escaping (_ result: Result<[UserRemote], NetworkError>) -> Void)
    func getPosts(userId: Int, completion: @escaping (_ result: Result<[PostRemote], NetworkError>) -> Void)
}


enum NetworkError: Error {
    
    case genericError
}

class PostService: PostServiceProtocol {
    
    func getUsers(completion: @escaping (_ result: Result<[UserRemote], NetworkError>) -> Void) {
        AF.request("https://jsonplaceholder.typicode.com/users").responseDecodable(of: [UserRemote].self) {
            response in
            
            guard let userReceived = response.value else {
                completion(.failure(.genericError))
                return
            }
            
            completion(.success(userReceived))
        }
    }
    
    func getPosts(userId: Int, completion: @escaping (_ result: Result<[PostRemote], NetworkError>) -> Void) {
        AF.request("https://jsonplaceholder.typicode.com/posts?userId=\(userId)").responseDecodable(of: [PostRemote].self) {
            response in
            guard let postReceived = response.value else {
                completion(.failure(.genericError))
                return
            }
            completion(.success(postReceived))
        }
    }
}
