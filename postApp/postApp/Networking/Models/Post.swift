//
//  Post.swift
//  postApp
//
//  Created by Andres Orjuela on 18/01/23.
//

import Foundation
import RealmSwift

struct PostRemote: Codable {
    
    let id: Int
    let userId: Int?
    let title: String?
    let body: String?
}

class Post: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var userId: Int = 0
    @objc dynamic var title: String?
    @objc dynamic var body: String?
}

