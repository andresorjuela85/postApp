//
//  PostsDataBase.swift
//  postApp
//
//  Created by Andres Orjuela on 18/01/23.
//

import Foundation
import RealmSwift

protocol PostsDataBaseProtocol {
    
    func saveUsers(_ users: [UserRemote])
    func getUsers() -> [User]
    func getPosts(userId: Int) -> [Post]
    func savePosts(_ posts: [PostRemote])
    
}

class PostsDataBase: PostsDataBaseProtocol {
    
    func saveUsers(_ users: [UserRemote]) {
        
        do {
            let realm = try Realm()
            let allObjects = realm.objects(User.self)
            
            try realm.write {
                realm.delete(allObjects)
            }
            
            for user in users {
                
                let usersRealm = User()
                usersRealm.id = user.id
                usersRealm.name = user.name
                usersRealm.phone = user.phone
                usersRealm.email = user.email
                try realm.write {
                    realm.add(usersRealm)
                }
            }
        } catch {
            print("DataBase error")
        }
    }
    
    func getUsers() -> [User] {
        
        do {
            let realm = try Realm()
            return Array(realm.objects(User.self))
        } catch {
            print("DataBase error")
            return []
        }
    }
    
    func getPosts(userId: Int) -> [Post] {
        
        do {
            let realm = try Realm()
            return Array(realm.objects(Post.self).filter("userId = \(userId)"))
        } catch {
            print("Database error")
            return []
        }
    }
    
    func savePosts(_ posts: [PostRemote]) {
        
        do {
            let realm = try Realm()
            
            for post in posts {
                
                let postsRealm = Post()
                postsRealm.id = post.id
                postsRealm.userId = post.userId ?? 0
                postsRealm.title = post.title
                postsRealm.body = post.body
                
                try realm.write {
                    realm.add(postsRealm)
                }
            }
        } catch {
            print("Database error")
        }
    }
    
    func deleteDatabase() {
        
        do {
            let realm = try Realm()
            
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("DataBase error")
        }
    }
}


