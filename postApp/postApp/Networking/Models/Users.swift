//
//  Users.swift
//  postApp
//
//  Created by Andres Orjuela on 18/01/23.
//

import Foundation
import RealmSwift

struct UserRemote: Codable {
    
    let id: Int
    let name: String?
    let email: String?
    let phone: String?
}

class User: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var phone: String?
    @objc dynamic var email: String?
}
