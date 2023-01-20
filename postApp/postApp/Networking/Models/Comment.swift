//
//  Comment.swift
//  postApp
//
//  Created by Andres Orjuela on 18/01/23.
//

import Foundation
import RealmSwift

struct CommentRemote: Codable {
    
    let postId: Int?
    let id: Int
    let name: String?
    let email: String?
    let body: String?
}

class Comment: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var postId: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var body: String?
    @objc dynamic var email: String?
}
