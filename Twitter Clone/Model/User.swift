//
//  User.swift
//  Twitter Clone
//
//  Created by Muharrem Efe Çayırbahçe on 3.09.2024.
//

import Foundation
import FirebaseAuth

struct User {
    let fullname: String
    let email: String
    let username: String
    let profileImageURL: URL
    let uid: String
    var isFollowing = false
    var stats: UserRelationStats?
    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == uid
    }
    
    init(uid: String, dictinary: [String: Any]) {
        self.uid = uid
        
        self.fullname = dictinary["fullname"] as? String ?? ""
        self.email = dictinary["email"] as? String ?? ""
        self.username = dictinary["username"] as? String ?? ""
        
        if let profileImageURLString = dictinary["profileImageURL"] as? String {
            self.profileImageURL = URL(string: profileImageURLString)!
        } else {
            self.profileImageURL = URL(string: "")!
        }
    }
}

struct UserRelationStats {
    var followers: Int
    var following: Int
}
