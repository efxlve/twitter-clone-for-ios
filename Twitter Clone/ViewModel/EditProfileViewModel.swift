//
//  EditProfileViewModel.swift
//  Twitter Clone
//
//  Created by Muharrem Efe Çayırbahçe on 30.09.2024.
//

import Foundation

enum EditProfileOptions: Int, CaseIterable {
    case fullname
    case username
    case bio
    
    var description: String {
        switch self {
        case .fullname: return "Fullname"
        case .username: return "Username"
        case .bio: return "Bio"
        }
    }
}
