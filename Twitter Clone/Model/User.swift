//
//  User.swift
//  Twitter Clone
//
//  Created by Muharrem Efe Çayırbahçe on 3.09.2024.
//

import Foundation
import FirebaseAuth

struct User {
    var fullname: String
    let email: String
    var username: String
    var profileImageURL: URL?
    let uid: String
    var isFollowing = false
    var stats: UserRelationStats?
    var bio: String?
    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == uid
    }
    
    init(uid: String, dictinary: [String: Any]) {
        self.uid = uid
        
        self.fullname = dictinary["fullname"] as? String ?? ""
        self.email = dictinary["email"] as? String ?? ""
        self.username = dictinary["username"] as? String ?? ""
        self.bio = dictinary["bio"] as? String ?? ""
        
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
