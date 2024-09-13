//
//  AuthService.swift
//  Twitter Clone
//
//  Created by Muharrem Efe Çayırbahçe on 2.09.2024.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import UIKit

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(withEmail email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(credentials: AuthCredentials, completion: @escaping (Error?, DatabaseReference) -> Void) {
        let email = credentials.email
        let password = credentials.password
        let fullname = credentials.fullname
        let username = credentials.username
        
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = PROFILE_IMAGE_REF.child(filename)
        
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            storageRef.downloadURL { (url, error) in
                guard let profileImageURL = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        print("DEBUG: Error is \(error.localizedDescription)")
                        return
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    let values = ["email": email, "username": username, "fullname": fullname, "profileImageURL": profileImageURL]
                    
                    USERS_REF.child(uid).updateChildValues(values, withCompletionBlock: completion)
                    
                    USERS_REF.child(uid).updateChildValues(values) { (error, ref) in
                        print("DEBUG: Successfully updated user information.")
                    }
                }
            }
        }
    }
}
