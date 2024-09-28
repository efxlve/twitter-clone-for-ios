//
//  Notification.swift
//  Twitter Clone
//
//  Created by Muharrem Efe Çayırbahçe on 22.09.2024.
//

import Foundation

enum NotificationType: Int {
    case follow
    case like
    case reply
    case retweet
    case mention
}

struct Notification {
    let tweetId: String?
    var timestamp: Date!
    let user: User
    var tweet: Tweet?
    var type: NotificationType!
    
    init(user: User, dictionary: [String : AnyObject]) {
        self.user = user
        
        self.tweetId = dictionary["tweetId"] as? String ?? ""
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        
        if let type = dictionary["type"] as? Int {
            self.type = NotificationType(rawValue: type)
        }
    }
}
